//
//  ScriptureView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 8/30/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI

struct ScriptureView: View {
    @State private var selection = 0
    let restP = RestPostman()
    @State var verses : [String]
    @State var prevChapter : [Int]
    @State var nextChapter : [Int]
    @State var canonical : String
    @State var showCanvas = false
    @State private var canvas = CanvasView()
    @State private var showPicker = false
    
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.restP.getRequest(reference: "\(self.prevChapter[0])-\(self.prevChapter[1])")
                    self.canonical = self.restP.canonical
                    
                    self.nextChapter = self.restP.nextChapter
                    self.prevChapter = self.restP.prevChapter
                }) {
                    Text("Previous Chapter")
                }
                Button(action: {
                    self.restP.getRequest(reference: "John+1")
                    self.canonical = self.restP.canonical
                    
                    self.nextChapter = self.restP.nextChapter
                    self.prevChapter = self.restP.prevChapter
                }) {
                    Text("Get John 1")
                }
                Button(action: {
                    self.restP.getRequest(reference: "\(self.nextChapter[0])-\(self.nextChapter[1])")
                    self.canonical = self.restP.canonical
                    
                    self.nextChapter = self.restP.nextChapter
                    self.prevChapter = self.restP.prevChapter
                }) {
                    Text("Next Chapter")
                }
                Button(action: {
                    self.showCanvas.toggle()
                    self.showPicker.toggle()
                }) {
                    Text("Toggle Canvas")
                }
            }
        
            
            HStack{
                ScrollView(.vertical) {
                    Text(self.canonical)
                        .font(.title)
                    Spacer()
                    ForEach(self.verses, id: \.self) { verse in
                        Text(verse)
                    }
                     .frame(width: 500)
                         .padding()
                 }
                
            
                if(self.showCanvas){
//                    ScrollView() {
//                        ForEach(self.verseNotes, id: \.self) { note in
//                            Text(note.text)
//                                .foregroundColor(Color.gray)
//                                .fontWeight(.light)
//                        }
                        Canvas(canvasView: $canvas, isActive: $showPicker).animation(.easeInOut(duration: 0.5))
//                    }
                }
            }
        }
    }
}
