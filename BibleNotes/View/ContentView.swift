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
    @State var verses : [String]
    @State var prevChapter : [Int]
    @State var nextChapter : [Int]
    @State var canonical : String
    let canvas = NotesView()
    
    var body: some View {
        HStack() {
            ScrollView(.vertical) {
                VStack{
                    HStack{
                        Button(action: {
                            self.restP.getRequest(reference: "\(self.prevChapter[0])-\(self.prevChapter[1])")
                            self.canonical = self.restP.canonical
                            self.verses = self.restP.versesText
                            self.nextChapter = self.restP.nextChapter
                            self.prevChapter = self.restP.prevChapter
                        }) {
                            Text("Previous Chapter")
                        }
                        Button(action: {
                            self.restP.getRequest(reference: "John+1")
                            self.canonical = self.restP.canonical
                            self.verses = self.restP.versesText
                            self.nextChapter = self.restP.nextChapter
                            self.prevChapter = self.restP.prevChapter
                        }) {
                            Text("Get John 1")
                        }
                        Button(action: {
                            self.restP.getRequest(reference: "\(self.nextChapter[0])-\(self.nextChapter[1])")
                            self.canonical = self.restP.canonical
                            self.verses = self.restP.versesText
                            self.nextChapter = self.restP.nextChapter
                            self.prevChapter = self.restP.prevChapter
                        }) {
                            Text("Next Chapter")
                        }
                    }
                    Text(self.canonical)
                        .font(.title)
                    Spacer()
                    ForEach(self.verses, id: \.self) { verse in
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
        ContentView(verses: ["The Word Became Flesh"], prevChapter: [42024001, 42024053], nextChapter: [43002001, 43002025], canonical: "John 1")
    }
}
