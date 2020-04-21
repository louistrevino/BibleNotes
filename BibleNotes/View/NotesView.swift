//
//  NotesView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/18/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI
import PencilKit

struct NotesView: View {
    let canvas = CanvasView()
    @State var showCanvas = true
    
    var body: some View {
        VStack {
            if(showCanvas) {
                HStack(){
                    Button(action: {
                        
                    }){
                        Text("Erase")
                    }
                    
                    Button(action: {
                        self.showCanvas = false
                    }) {
                        Text("Hide Canvas")
                    }
                }
                canvas
                    
            } else {
                HStack(){
                    Button(action: {
                        
                    }){
                        Text("Erase")
                    }
                    
                    Button(action: {
                        self.showCanvas = true
                    }) {
                        Text("Show Canvas")
                    }
                }
                Text("No Canvas")
            }
        }
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
