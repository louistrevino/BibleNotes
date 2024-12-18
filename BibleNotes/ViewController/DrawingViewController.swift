//
//  DrawingViewController.swift
//  BibleNotes
//
//  Created by Louis Trevino on 7/5/21.
//  Copyright © 2021 Louis Trevino. All rights reserved.
//

import UIKit
import PencilKit

class DrawingViewController: UIViewController {

    lazy var canvas: PKCanvasView = {
        let v = PKCanvasView()
//        v.drawingPolicy = .anyInput
        v.minimumZoomScale = 1
        v.maximumZoomScale = 5
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        toolPicker.addObserver(self)
        return toolPicker
    }()
    
    var data = Data()
    
    var drawingChanged: (Data) -> Void = { _ in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvas)
        
        NSLayoutConstraint.activate([
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvas.topAnchor.constraint(equalTo: view.topAnchor),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.delegate = self
        canvas.becomeFirstResponder()
        
        if let drawing = try? PKDrawing(data: data) {
            canvas.drawing = drawing
        }
    }
    

}


//MARK:- PK Delegates
extension DrawingViewController: PKToolPickerObserver, PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        drawingChanged(canvasView.drawing.dataRepresentation())
        
    }
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
        canvas.becomeFirstResponder()
    }
    
}
