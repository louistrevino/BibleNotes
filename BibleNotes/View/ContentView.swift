//
//  ContentView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/5/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI
import PencilKit


@available(iOS 14.0, *)
struct ContentView: View {
    @State private var selection = 0
    @ObservedObject var restP = RestPostman()
    @State var showCanvas = false
    @State private var showPicker = false
    @State var canvas = CanvasView()
    @State var dmc = DataModelController()
    @State var updateDrawing = ""
    
    
    var body: some View {
        NavigationView {
            ListItemView().environmentObject(restP)
            VStack{
                HStack{
                    Button(action: {
                        DispatchQueue.main.async {
                            self.updateDrawing = self.restP.canonical
                            self.restP.getRequest(reference: "\(self.restP.prevChapter[0])-\(self.restP.prevChapter[1])")

                        }
                    }) {
                        Text("Previous Chapter")
                    }
                    Button(action: {
                        DispatchQueue.main.async {
                            self.restP.getRequest(reference: "John+1")
                        }

                    }) {
                        Text("Get John 1")
                    }
                    Button(action: {
                        DispatchQueue.main.async {
                            self.updateDrawing = self.restP.canonical
                            self.restP.getRequest(reference: "\(self.restP.nextChapter[0])-\(self.restP.nextChapter[1])")
                        }
                    }) {
                        Text("Next Chapter")
                    }
                    Button(action: {
                        self.showPicker.toggle()
                        self.showCanvas.toggle()
                        self.updateDrawing = self.restP.canonical

                    }) {
                        Text("Toggle Canvas")
                    }
                }


                HStack{
                    ScrollView(.vertical) {
                        VStack{
//                            Text(self.restP.canonical)
//                                .font(.title)
//                            Spacer()
                            ForEach(self.restP.versesText, id: \.self) { verse in
                                Text(verse)
                            }
                        }
                        .frame(width: 500)
                            .padding()

                    }

                    if(showCanvas) {
                        Canvas(canvasView: $canvas, isActive: $showPicker, currentCanvas: $restP.canonical,  dmc: $dmc, updateDrawing: $updateDrawing)
                    }
                }
                .navigationBarTitle(restP.canonical, displayMode: .inline)
            }.onAppear(perform: loadData)
        }
    }
    func loadData() {
        restP.getRequest(reference: "john1")
    }
}
