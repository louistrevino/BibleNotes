//
//  TranslationHelper.swift
//  BibleNotes
//
//  Created by Louis Treviño on 3/4/22.
//  Copyright © 2022 Louis Trevino. All rights reserved.
//

import Foundation

class TranslationHelper {
    
    func convertVersesToAttributedString(verses: [Verse]) -> NSAttributedString {
        var verseArray = [String]()
        for verse in verses {
            verseArray.append("\(verse.number). \(verse.text)")
        }
        
        return createAttributedString(stringArray: verseArray, attributedPart: verseArray.count) ?? NSMutableAttributedString(string: "")
    }
    func createAttributedString(stringArray: [String], attributedPart: Int) -> NSMutableAttributedString? {
        
        let attributes = [NSAttributedString.Key: Any]()
        
        let finalString = NSMutableAttributedString()
        
        for i in 0 ..< stringArray.count {
            var attributedString = NSMutableAttributedString(string: stringArray[i], attributes: nil)
            if i == attributedPart {
                attributedString = NSMutableAttributedString(string: attributedString.string, attributes: attributes)
                finalString.append(attributedString)
            } else {
                finalString.append(attributedString)
            }
        }
        return finalString
    }
}
