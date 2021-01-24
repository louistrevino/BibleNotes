//
//  DetailsView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 10/6/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI

struct DetailsView : View {
    @State var restP : RestPostman
    @ObservedObject var vars : Vars
    @State var canvas = CanvasView()
    @State var dmc = DataModelController()
    @State var updateDrawing = ""
    
    var body: some View {
        VStack{
            HStack{
                // TODO: set this up to where canvas opens in a second window
                if(!vars.showCanvas) {
                    ScrollView(.vertical) {
                        LazyVStack{
                            ForEach(self.restP.versesText, id: \.self) { verse in
                                Text(verse)
                            }
                        }
                        .frame(width: 500)
                            .padding()

                    }
                }
                else {
                    Canvas(canvasView: $canvas, vars: self.vars, currentCanvas: $restP.canonical,  dmc: $dmc, updateDrawing: $restP.canonical)
                        .padding()
                        .clipShape(Rectangle()).overlay(Rectangle()
                                                            .stroke(Color.gray, lineWidth: 3))
                }
            }
            .navigationBarTitle(restP.canonical, displayMode: !vars.showCanvas ? .automatic : .inline)
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
        restP.getRequest(reference: "john1")
    }
}

class Vars : ObservableObject{
    @Published var showCanvas = false
}
