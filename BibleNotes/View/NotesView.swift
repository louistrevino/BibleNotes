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
//    @State var views : [NoteView<>]?
    var body: some View {
//        ScrollView() {
//            ForEach(views? ?? [NoteView()]) { view in
//                view
//            }
        Text("test")
//        }
    }
}

struct NotesCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        NotesCanvasView()
    }
}

struct NoteView<Content: View> : View {
    
    var canvas : Canvas
//    var scriptureView : ScriptureView
    var body: some View {
        if (canvas != nil) {
            canvas
        } else {
//            scriptureView
        }
    }
    
}
