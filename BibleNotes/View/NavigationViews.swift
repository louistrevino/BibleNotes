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

struct ListItemRow : Identifiable {
    var id = UUID()
    var name : String
    var totalChapters : Int?
}

struct ListItemView : View {

    var books = [
        ListItemRow(name: "Matthew", totalChapters: 28),
        ListItemRow(name: "Mark", totalChapters: 16),
        ListItemRow(name: "Luke", totalChapters: 24),
        ListItemRow(name: "John", totalChapters: 21)
    ]

    @EnvironmentObject var restP : RestPostman
    var body: some View {
        List {
            ForEach(books, id: \.id) { section in
                Section(header: Text(section.name)) {
                    ForEach(1..<section.totalChapters! + 1) { number in
                        Button("Chapter \(number)") {
                            restP.getRequest(reference: "\(section.name)+\(number)")
                        }
                    }
                }
            }
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
