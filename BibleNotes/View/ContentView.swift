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
    @State var showCanvas = false
    @State private var showPicker = false
    @State var canvas = CanvasView()
    @State var dmc = DataModelController()
    @State var updateDrawing = ""
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.updateDrawing = self.canonical
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
                    self.updateDrawing = self.canonical
                    self.restP.getRequest(reference: "\(self.nextChapter[0])-\(self.nextChapter[1])")
                    self.canonical = self.restP.canonical
                    self.verses = self.restP.versesText
                    self.nextChapter = self.restP.nextChapter
                    self.prevChapter = self.restP.prevChapter

                }) {
                    Text("Next Chapter")
                }
                Button(action: {
                    self.showPicker.toggle()
                    self.showCanvas.toggle()
                    self.updateDrawing = self.canonical

                }) {
                    Text("Toggle Canvas")
                }
            }
        
            
            HStack{
                ScrollView(.vertical) {
                    VStack{
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
                
                if(showCanvas) {
                    Canvas(canvasView: $canvas, isActive: $showPicker, currentCanvas: $canonical,  dmc: $dmc, updateDrawing: $updateDrawing)
                }
            }
            
        }
    }
}
