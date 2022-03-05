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
    @State private var textStyle = UIFont.TextStyle.body
    @State private var selectedVerseTrigger = false
    var body: some View {
        VStack(alignment: .leading){
            Button(action: {
            addMultipleVerseData(verses: vars.versesSelected)
                }) {
                    Image(systemName: "textformat")
                        .imageScale(.large)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .clipShape(Circle())
         
                }
                .padding()
            HStack{
                // TODO: set this up to where canvas opens in a second window
                TextView(vars: vars, text: TranslationHelper.highlightText(verses: self.vars.verses, selectedVerses: vars.versesSelected), textStyle: $textStyle, selectedVerseTrigger: $selectedVerseTrigger)
                    .frame(width: 500)
                        .padding()
                        .onChange(of: vars.versesSelected, perform: { _ in
                            selectedVerseTrigger = false
                        })
                    
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
    
    func addMultipleVerseData(verses: [Verse]) {
        var numbers = [Int]()
        for verse in verses {
            if !numbers.contains(verse.number) {
                numbers.append(verse.number)
            }
        }
        numbers.sort()
        
        var name = "\(vars.reference):"
        for ref in numbers {
            name.append("\(ref),")
        }
        name.removeLast()
        vars.versesSelected = [Verse]()
        addData(verseInfo: name)
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
    @Published var versesSelected = [Verse]()
}
