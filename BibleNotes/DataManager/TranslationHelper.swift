//
//  TranslationHelper.swift
//  BibleNotes
//
//  Created by Louis Treviño on 3/4/22.
//  Copyright © 2022 Louis Trevino. All rights reserved.
//

import Foundation
import UIKit

class TranslationHelper {
    
    static func convertVersesToAttributedString(verses: [Verse]) -> NSAttributedString {
        var verseArray = [String]()
        for verse in verses {
            verseArray.append("\(verse.number). \(verse.text)")
        }
        
        return createAttributedString(stringArray: verseArray, attributedPart: verseArray.count) ?? NSMutableAttributedString(string: "")
    }
    
    static func createAttributedString(stringArray: [String], attributedPart: Int) -> NSMutableAttributedString? {
        
        let finalString = NSMutableAttributedString()
        
        for i in 0 ..< stringArray.count {
            let attributes : [NSAttributedString.Key: Any] = [
                .link: "\(i+1)//"
            ]
            var attributedString = NSMutableAttributedString(string: stringArray[i], attributes: attributes)
            let str : NSString = attributedString.string as NSString
            
            attributedString = NSMutableAttributedString(string: attributedString.string)
            attributedString.addAttributes(attributes, range: str.range(of: stringArray[i]))
            finalString.append(attributedString)
            
        }
        return finalString
    }
    
    static func highlightText(verses: [Verse], selectedVerses: [Verse]) -> NSAttributedString {
        
        
        let finalString = NSMutableAttributedString()
        var selectedRefs = [String]()
        
        for verse in selectedVerses {
            selectedRefs.append("\(verse.number)")
        }
        
        for i in 0 ..< verses.count {
            let attributes : [NSAttributedString.Key: Any]
            if selectedRefs.contains("\(i+1)") {
                attributes = [
                    .link: "\(i+1)//",
                    .backgroundColor : UIColor.yellow
                ]
            } else {
                attributes = [
                    .link: "\(i+1)//"
                ]
            }
            
            var attributedString = NSMutableAttributedString(string: "\(verses[i].number). \(verses[i].text)", attributes: attributes)
            let str : NSString = attributedString.string as NSString
            
            
            attributedString = NSMutableAttributedString(string: attributedString.string)
            attributedString.addAttributes(attributes, range: str.range(of: "\(verses[i].number). \(verses[i].text)"))
            finalString.append(attributedString)
            
        }
        
        return finalString
    }

}

