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
    @ObservedObject var manager = DrawingManager(book: "john", chapter: 1)
    @State private var addNewShown = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(manager.docs) { doc in
                    NavigationLink(destination: DrawingWrapper(manager: manager, id: doc.id), label: { Text(verbatim: doc.name)})
                }
            }
        }
    }
}
