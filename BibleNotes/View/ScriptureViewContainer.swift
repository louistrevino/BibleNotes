//
//  ScriptureView.swift
//  BibleNotes
//
//  Created by Louis Treviño on 3/3/22.
//  Copyright © 2022 Louis Trevino. All rights reserved.
//

import Foundation
import SwiftUI

struct TextView : UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator(scriptureViewController: self)
    }
    

    var text: NSAttributedString
    @Binding var textStyle: UIFont.TextStyle
    
    func makeUIViewController(context: Context) -> ScriptureViewController {
        let textView = ScriptureViewController()
 
        textView.textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.textView.autocapitalizationType = .sentences
        textView.textView.isSelectable = true
        textView.textView.isUserInteractionEnabled = true
 
        return textView
    }
    
    func updateUIViewController(_ uiViewController: ScriptureViewController, context: Context)  {
        uiViewController.textView.attributedText = text
        uiViewController.textView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var textView: TextView

        init(scriptureViewController: TextView) {
            self.textView = scriptureViewController
        }

        func documentPicker(_ controller: TextView, didPickDocumentsAt urls: [URL]) {
            
        }
    }
}

