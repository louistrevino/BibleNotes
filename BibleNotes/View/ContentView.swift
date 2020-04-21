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
    let canvas = NotesView()
    
    var body: some View {
        HStack() {
            ScrollView(.vertical) {
                VStack{
                    Button(action: {
                        var nextVerseString = ""
                        for verseRef in self.prevChapter[0]...self.prevChapter[1] {
                            nextVerseString.append("\(verseRef)")
                            if(verseRef != self.prevChapter[1]){
                                nextVerseString.append(",")
                            }
                        }
                        self.restP.getRequest(reference: nextVerseString)
                        self.verses = self.restP.versesText
                        self.nextChapter = self.restP.nextChapter
                        self.prevChapter = self.restP.prevChapter
                    }) {
                        Text("Get Text")
                    }
                    Button(action: {
                        self.restP.getRequest(reference: "John+1")
                        self.verses = self.restP.versesText
                        self.nextChapter = self.restP.nextChapter
                        self.prevChapter = self.restP.prevChapter
                    }) {
                        Text("Get John 1")
                    }
                    Button(action: {
                        var nextVerseString = ""
                        for verseRef in self.prevChapter[0]...self.prevChapter[1] {
                            nextVerseString.append("\(verseRef)")
                            if(verseRef != self.prevChapter[1]){
                                nextVerseString.append(",")
                            }
                        }
                        self.restP.getRequest(reference: nextVerseString)
                        self.verses = self.restP.versesText
                        self.nextChapter = self.restP.nextChapter
                        self.prevChapter = self.restP.prevChapter
                    }) {
                        Text("Next Chapter")
                    }
                    
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
        ContentView(verses: ["The Word Became Flesh"], prevChapter: [42024001, 42024053], nextChapter: [43002001, 43002025])
    }
}
