//
//  ScriptureView.swift
//  BibleNotes
//
//  Created by Louis Treviño on 3/3/22.
//  Copyright © 2022 Louis Trevino. All rights reserved.
//

import Foundation
import SwiftUI

struct TextView : UIViewRepresentable {


    var vars : Vars
    var text: NSAttributedString
    @Binding var textStyle: UIFont.TextStyle
    @Binding var selectedVerseTrigger : Bool
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
 
        textView.font = UIFont.preferredFont(forTextStyle: textStyle)
        textView.autocapitalizationType = .sentences
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.linkTextAttributes = [.foregroundColor: UIColor.black]
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = text
        uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var textView: TextView
        var vars : Vars
        var selectedVerseTrigger : Bool

        init(_ textView: TextView, _ vars: Vars, _ selectedVerseTrigger: Bool) {
            self.textView = textView
            self.vars = vars
            self.selectedVerseTrigger = selectedVerseTrigger
        }
        
        func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            let token = URL.absoluteString.components(separatedBy: "//")
            let reference = token[0]
            let text = token[1]
            let verse = Verse(number: Int(reference) ?? 0, text: text)
            vars.versesSelected.append(verse)
            textView.attributedText = TranslationHelper.highlightText(verses: vars.verses, selectedVerses: vars.versesSelected)
            selectedVerseTrigger = false
            return false
            
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self, vars, selectedVerseTrigger)
    }
    
}
