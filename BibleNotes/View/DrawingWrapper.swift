//
//  DrawingWrapper.swift
//  BibleNotes
//
//  Created by Louis Trevino on 7/5/21.
//  Copyright © 2021 Louis Trevino. All rights reserved.
//
//  This just translates the DrawingViewController into something that can be
//  used in SwiftUI

import SwiftUI

struct DrawingWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = DrawingViewController
    
    var manager: DrawingManager
    var id: UUID
    
    func makeUIViewController(context: Context) -> DrawingViewController {
        let viewController = DrawingViewController()
        viewController.data = manager.getData(for: id)
        viewController.drawingChanged = { data in
            manager.update(data: data, for: id)
        }
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: DrawingViewController, context: Context) {
        uiViewController.data = manager.getData(for: id)
    }
}
