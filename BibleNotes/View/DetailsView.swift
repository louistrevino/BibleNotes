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
    @State var canvas = CanvasView()
    @State var dmc = DataModelController()
    @State var updateDrawing = ""
    @State var showPopOverMenu = false;
    @State var selectedVerse = ""
    @State var noteButtonTapped = false;
    @State var notes : [Note] = []
    var body: some View {
        VStack{
            Button(action: {
                showPopOverMenu = false
            }) {
                Text("Hide PopOver")
            }
            HStack{
                // TODO: set this up to where canvas opens in a second window
                ZStack {
                    ScrollView(.vertical) {
                        
                            LazyVStack{
                                ForEach(self.restP.versesText, id: \.self) { verse in
                                    Text(verse)
                                        .onTapGesture {
                                            showPopOverMenu = true
                                            self.selectedVerse = verse
                                            print(selectedVerse)
                                        }
                                }
                            }
                            .frame(width: 500)
                                .padding()
                    }
                    if showPopOverMenu {
                        PopUpMenu(selectedVerse: selectedVerse, showPopOverMenu: showPopOverMenu, noteButtonTapped: noteButtonTapped, notes: notes)
                            .cornerRadius(15)
                    }
                }
                if(!vars.showCanvas) {
//                    Canvas(canvasView: $canvas, vars: self.vars, currentCanvas: $restP.canonical,  dmc: $dmc, updateDrawing: $restP.canonical)
//                        .padding()
//                        .clipShape(Rectangle()).overlay(Rectangle()
//                                                            .stroke(Color.gray, lineWidth: 3))
                    
                    NotesCanvasView(notes: notes)
                    
                }
            }
            .navigationBarTitle(restP.canonical, displayMode: !vars.showCanvas ? .automatic : .inline)
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
        restP.getRequest(reference: "john1")
    }
}

class Vars : ObservableObject{
    @Published var showCanvas = false
}

struct PopUpMenu : View {
    @State var selectedVerse : String
    @State var showPopOverMenu : Bool
    @State var noteButtonTapped : Bool
    @State var note = Note()
    @State var notes : [Note]
    var body: some View {
        HStack {
            Button(action: {
                note.selectedVerse = selectedVerse
                notes.append(note)
                printButtonTap(message: "note tapped. selectedVerse = \(selectedVerse)")
            }) {
                Text("Note")
            }
            Divider()
            Button(action: {
                printButtonTap(message: "Highlight tapped")
            }) {
                Text("Highlight")
            }
        }.frame(width: 300, height: 30)
        .background(Color.black)
        .foregroundColor(Color.white)
        .padding()
        .onTapGesture {
            showPopOverMenu = false
        }
    }
    
    func printButtonTap(message : String) {
        print(message)
        print("")
    }
}
