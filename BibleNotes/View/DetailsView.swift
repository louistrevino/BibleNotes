//
//  DetailsView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 10/6/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI

struct DetailsView : View {
    @State var restP : RestPostman
    @ObservedObject var vars : Vars
//    @State var canvas = CanvasView()
    @State var dmc = DataModelController()
    @State var updateDrawing = ""
    @ObservedObject var manager : DrawingManager
    @State private var addNewShown = false

    var body: some View {
        VStack{
            HStack{
                // TODO: set this up to where canvas opens in a second window
                if(!vars.showCanvas) {
                    ScrollView(.vertical) {
                        LazyVStack{
                            ForEach(self.restP.versesText, id: \.self) { verse in
                                Text(verse)
                            }
                        }
                        .frame(width: 500)
                            .padding()
                    }
                }
                else {
                    NavigationView {
                        List {
                            ForEach(manager.docs) { doc in
                                NavigationLink(destination: DrawingWrapper(manager: manager, id: doc.id), label: { Text(doc.name)})
                            }
                        }
                        .navigationBarItems(trailing: Button("Add") {
                            addData();
                        })
                    }
                }
            }
            .navigationBarTitle(restP.canonical, displayMode: .automatic)
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
        restP.getRequest(reference: "john1")
    }
    
    func addData() {
        manager.addData(doc: DrawingDocument(id: UUID(), data: Data(), name: "drawing", book: restP.canonical.trimmingCharacters(in: CharacterSet(charactersIn: "1234567890: ")), chapter: Int32(vars.i)));
        print("detailsView \(vars.i)")
    }
}

class Vars : ObservableObject{
    @Published var showCanvas = false
    @Published var i = 1
}
