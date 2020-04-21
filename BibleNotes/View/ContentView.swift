//
//  ContentView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/5/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    @State private var selection = 0
    let restP = RestPostman()
    @State var stateVerse = [String]()
    let canvas = NotesView()
    
    var body: some View {
        HStack() {
            ScrollView(.vertical) {
                VStack{
                    Button(action: {
                        self.restP.getRequest()
                        self.stateVerse = self.restP.versesText
                    }) {
                        Text("Get Text")
                    }
                    
                    ForEach(self.stateVerse, id: \.self) { verse in
                        Text(verse)
                    }
                }
                .frame(width: 500)
                    .padding()
                
            }
            
            VStack{
                NotesView()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
