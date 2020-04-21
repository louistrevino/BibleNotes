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
    
    func makeUIView(context: Context) -> PKCanvasView {
        PKCanvasView(frame: .zero)
        
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

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        CanvasView()
    }
}
