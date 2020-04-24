//
//  CanvasView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/19/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    
    }
    
    
    class Coordinator : NSObject, PKCanvasViewDelegate, UINavigationControllerDelegate, PKToolPickerObserver {
        var parent: CanvasView
        
        init(_ parent : CanvasView) {
            self.parent = parent
        }
        
        
        func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
            if let window = canvasView.inputView?.window, let toolPicker = PKToolPicker.shared(for: window) {
                toolPicker.setVisible(true, forFirstResponder: canvasView)
                toolPicker.addObserver(canvasView)
                toolPicker.addObserver(self)
                
                updateLayout(canvasView, for: toolPicker)
                canvasView.becomeFirstResponder()
            }
        }
        
        func updateLayout(_ canvasView : PKCanvasView, for toolPicker: PKToolPicker) {
            let obscuredFrame = toolPicker.frameObscured(in: canvasView.inputView!)
            
            // If the tool picker is floating over the canvas, it also contains
            // undo and redo buttons.
            if obscuredFrame.isNull {
                canvasView.contentInset = .zero
//                navigationItem.leftBarButtonItems = []
            }
            
            // Otherwise, the bottom of the canvas should be inset to the top of the
            // tool picker, and the tool picker no longer displays its own undo and
            // redo buttons.
            else {
                canvasView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: canvasView.i.bounds.maxY - obscuredFrame.minY, right: 0)
//                navigationItem.leftBarButtonItems = [undoBarButtonitem, redoBarButtonItem]
            }
            canvasView.scrollIndicatorInsets = canvasView.contentInset
        }
        
    }
    
//    @Binding var drawing : PKDrawing?
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView(frame: .zero)
        canvas.delegate = context.coordinator
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        let window = UIWindow()
        uiView.tool = PKInkingTool(.pen, color: .black, width: 10)
        let toolPicker = PKToolPicker.shared(for: window)
        toolPicker?.addObserver(uiView)
        toolPicker?.setVisible(true, forFirstResponder: uiView)
        uiView.becomeFirstResponder()
        uiView.isScrollEnabled = true
    }
}

//struct CanvasView_Previews: PreviewProvider {
//    static var previews: some View {
//        CanvasView()
//    }
//}
