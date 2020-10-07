//
//  DetailsView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 10/6/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI

struct DetailsView : View {
    @ObservedObject var restP : RestPostman
    @ObservedObject var vars : Vars
    @State var canvas = CanvasView()
    @State var dmc = DataModelController()
    @State var updateDrawing = ""
    
    var body: some View {
        VStack{
            HStack{
                ScrollView(.vertical) {
                    VStack{
                        ForEach(self.restP.versesText, id: \.self) { verse in
                            Text(verse)
                        }
                    }
                    .frame(width: 500)
                        .padding()

                }

                if(vars.showCanvas) {
                    Canvas(canvasView: $canvas, vars: self.vars, currentCanvas: $restP.canonical,  dmc: $dmc, updateDrawing: $updateDrawing)
                }
            }
            .navigationBarTitle(restP.canonical, displayMode: .automatic)
        }.onAppear(perform: loadData)
    }
    
    func loadData() {
        restP.getRequest(reference: "john1")
    }
}

class Vars : ObservableObject{
    @Published var showCanvas = false
}
