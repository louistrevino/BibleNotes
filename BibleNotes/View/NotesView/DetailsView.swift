//
//  DetailsView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 10/6/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI

struct DetailsView : View {
    @State var translationManager : TranslationManager
    @ObservedObject var vars : Vars
//    @State var canvas = CanvasView()
//    @State var dmc = DataModelController()
    @State var updateDrawing = ""
    @ObservedObject var manager : DrawingManager
    @State private var addNewShown = false

    var body: some View {
        VStack{
            HStack{
                // TODO: set this up to where canvas opens in a second window
                 
                ScrollView(.vertical) {
                    LazyVStack{
                        ForEach(self.vars.verses, id: \.id) { verse in
                            Text("\(verse.number). \(verse.text)")
                        }
                    }
                    .frame(width: 500)
                        .padding()
                }
                
                if(vars.showCanvas) {
                    NavigationView {
                        List {
                            ForEach(manager.docs) { doc in
                                NavigationLink(destination: DrawingWrapper(manager: manager, id: doc.id), label: { Text(doc.name)})
                            }
                        }
                        .navigationBarItems(trailing: Button("Add") {
                            addData();
                        })
                    }.navigationViewStyle(StackNavigationViewStyle())
                }
            }
            .navigationBarTitle(self.vars.reference, displayMode: .automatic)
        }
    }
    
    func addData() {
        manager.addData(doc: DrawingDocument(id: UUID(), data: Data(), name: "drawing", book: self.vars.reference.trimmingCharacters(in: CharacterSet(charactersIn: "1234567890: ")), chapter: Int32(vars.i)));
        print("detailsView \(vars.i)")
    }
}

class Vars : ObservableObject{
    @Published var showCanvas = false
    @Published var i = 1
    
    @Published var reference = ""
    @Published var verses = [Verse]()
}
