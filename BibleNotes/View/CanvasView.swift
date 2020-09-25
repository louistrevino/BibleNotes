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

    @Binding var canvasView: CanvasView
    @Binding var isActive: Bool
    @Binding var currentCanvas: String
    
    func makeUIView(context: Context) -> CanvasView {
        
        return canvasView
    }

    func updateUIView(_ uiView: CanvasView, context: Context) {
        
        guard let window = uiView.window else { return }

        let picker = PKToolPicker.shared(for: window)
        picker?.setVisible(isActive, forFirstResponder: uiView)
        picker?.addObserver(uiView)
        DispatchQueue.main.async {
            uiView.becomeFirstResponder()
        }
        
    }
}

class CanvasView: PKCanvasView {
    override var canBecomeFirstResponder: Bool { true }
}
//struct CanvasView_Previews: PreviewProvider {
//    static var previews: some View {
//        CanvasView()
//    }
//}
