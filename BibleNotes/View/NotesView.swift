//
//  NotesView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/18/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI
import PencilKit

struct NotesCanvasView: View {
    @State var notes : [Note]
    var body: some View {
        List (notes) { note in
            NoteView(note: note)
        }
    }
}

struct Note : Identifiable {
    var id = UUID()
    var selectedVerse : String = ""
    @State var userText : String = ""

}

struct NoteView : View {
    var note : Note
    
    @State var userText = ""
    var body: some View {
        Text(note.selectedVerse)
            .font(.subheadline)
        TextEditor(text: note.$userText)
    }
    
}
