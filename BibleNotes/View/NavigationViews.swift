//
//  NavigationViews.swift
//  BibleNotes
//
//  Created by Louis Trevino on 9/29/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import Foundation
import SwiftUI

struct MenuView : View{
    
    var body: some View {
        Text("Menu")
    }
}

struct MenuButton : View {
    var text : String
    var body: some View {
        Text(text)
            .font(.body)
            .padding()
    }
}

struct ChaptersView : View {
    @EnvironmentObject var restP : RestPostman
    var book : String
    var totalChapters : Int
    
    var body: some View {
        Section {
            ForEach((1...totalChapters), id: \.self) { chapter in
                MenuButton(text: "Chapter \(chapter)")
                    .onTapGesture(){
                        self.restP.getRequest(reference: "\(book)+\(chapter)")
                    }
            }
        }.font(.body)
    }
}

struct ListItemRow : View {
    var id = UUID()
    var book : String
    var totalChapters : Int
    @State var showChapters : Bool = false
    @EnvironmentObject var restP : RestPostman
    var body: some View {
        VStack(alignment: .leading) {
            Button(book) {
                showChapters.toggle()
            }
            if(showChapters) {
                ChaptersView(book: book, totalChapters: totalChapters).environmentObject(restP)
            }
        }
    }
}

struct ListItemView : View {

    var listItemRows : [ListItemRow] = [
        ListItemRow(book: "Matthew", totalChapters: 28),
        ListItemRow(book: "Mark", totalChapters: 16),
        ListItemRow(book: "Luke", totalChapters: 24),
        ListItemRow(book: "John", totalChapters: 21)
    ]
    @EnvironmentObject var restP : RestPostman
    var body: some View {
        VStack(alignment: .leading) {
            List (listItemRows, id: \.id) { row in
                row.environmentObject(restP)
            }
            Spacer()
        }
    }
}

struct SubMenuView : View {
    var book : String
    var chapters : [String]
    @EnvironmentObject var restP : RestPostman
    
    var body: some View {
        Text("View")
    }

}

struct NavMenuView : View {
    
    @ObservedObject var restP : RestPostman
    @ObservedObject var vars : Vars
    @State var canvas = CanvasView()
    @State var dmc = DataModelController()
    @State var updateDrawing = ""
    
    var body: some View {
        HStack{
            Button(action: {
                DispatchQueue.main.async {
                    self.updateDrawing = self.restP.canonical
                    self.restP.getRequest(reference: "\(self.restP.prevChapter[0])-\(self.restP.prevChapter[1])")

                }
            }) {
                Text("Previous Chapter")
            }
            Button(action: {
                DispatchQueue.main.async {
                    self.restP.getRequest(reference: "John+1")
                }

            }) {
                Text("Get John 1")
            }
            Button(action: {
                DispatchQueue.main.async {
                    self.updateDrawing = self.restP.canonical
                    self.restP.getRequest(reference: "\(self.restP.nextChapter[0])-\(self.restP.nextChapter[1])")
                }
            }) {
                Text("Next Chapter")
            }
            Button(action: {
                vars.showCanvas.toggle()
                self.updateDrawing = self.restP.canonical

            }) {
                Text("Toggle Canvas")
            }
        }
    }
}
