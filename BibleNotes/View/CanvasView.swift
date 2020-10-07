//
//  CanvasView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/19/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI
import PencilKit

struct Canvas: UIViewRepresentable {

    @Binding var canvasView : CanvasView
    @ObservedObject var vars : Vars
    @Binding var currentCanvas : String
    @Binding var dmc : DataModelController
    @Binding var updateDrawing : String
    
    func makeUIView(context: Context) -> CanvasView {
        canvasView.isScrollEnabled = true
        return canvasView
    }

    func updateUIView(_ uiView: CanvasView, context: Context) {
        print("isActive = \(vars.showCanvas)")
        print("currentCanvas = \(currentCanvas)")
        print("dmc.drawings = \(dmc.drawings)")
        if dmc.drawings[currentCanvas] == nil {
            dmc.newDrawing(reference: currentCanvas)
            print("drawings = \(dmc.drawings)")

        } else {
            dmc.updateDrawing(canvasView.drawing, at: updateDrawing)
        }
        canvasView.drawing = dmc.drawings[currentCanvas] ?? PKDrawing()

        let picker = PKToolPicker()
        picker.setVisible(vars.showCanvas, forFirstResponder: canvasView)
        picker.addObserver(uiView)
        DispatchQueue.main.async {
            canvasView.becomeFirstResponder()
        }

    }
}

class CanvasView: PKCanvasView {
    
    override var canBecomeFirstResponder: Bool { true }
}
