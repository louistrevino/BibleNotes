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
//    @ObservedObject var textOverlay : DrawingManager
    @State private var addNewShown = false

    var body: some View {
        VStack(alignment: .leading){
            HStack{
                // TODO: set this up to where canvas opens in a second window
               

                ScrollView(.vertical) {
                    LazyVStack(alignment: .leading){
                        ForEach(self.vars.verses, id: \.id) { verse in
                            Text("\(verse.number). \(verse.text)")
                                .onTapGesture {
                                    addData(verseInfo: "\(vars.reference):\(verse.number)")
                                }
                        }
                    }
                }
                .frame(width: 500)
                    .padding()
                        
                    
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
        
    func addData(verseInfo: String) {
        manager.addData(doc: DrawingDocument(id: UUID(), data: Data(), name: verseInfo, book: vars.reference.trimmingCharacters(in: CharacterSet(charactersIn: "1234567890: ")), chapter: Int32(vars.i)));
    }
    
    func addData() {
        addData(verseInfo: "new drawing")
    }
    
//    func getUuidForDrawing() -> UUID{
//        return textOverlay.getUuidByReference(reference: vars.overlayReference, chapter: Int32(vars.i))
//    }

}

class Vars : ObservableObject{
    @Published var showCanvas = false
    @Published var showAnnotations = false
    @Published var i = 1
    
    @Published var reference = ""
    @Published var overlayReference = ""
    @Published var verses = [Verse]()
}

struct extraView : View {
    @ObservedObject var vars : Vars
    @ObservedObject var manager : DrawingManager
    
    var body: some View {
        LazyVStack {
            ForEach(self.vars.verses, id: \.id) { verse in
                Text("\(verse.number). \(verse.text)")
                    .onTapGesture {
                        addData(verseInfo: "\(vars.reference):\(verse.number)")
                    }
            }
        }
        .frame(width: 500)
            .padding()
    }
    
    func addData(verseInfo: String) {
        manager.addData(doc: DrawingDocument(id: UUID(), data: Data(), name: verseInfo, book: vars.reference.trimmingCharacters(in: CharacterSet(charactersIn: "1234567890: ")), chapter: Int32(vars.i)));
    }
    
    func addData() {
        addData(verseInfo: "new drawing")
    }
}
