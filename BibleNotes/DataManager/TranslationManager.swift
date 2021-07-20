//
//  TranslationManager.swift
//  BibleNotes
//
//  Created by Louis Trevino on 7/10/21.
//  Copyright © 2021 Louis Trevino. All rights reserved.
//
import SwiftUI

enum Translations {
    case ESV
    case NASB
    case NIV
    case KJV
    case ASV
}

class TranslationManager : ObservableObject {
    
    let esvManager : ESVWebService = ESVWebService()
    
    init(){}
    
    func getPassage(reference : String, translation: Translations, completion: @escaping (Chapter) -> ()) {
        
        switch translation {
            case Translations.ESV:
                esvManager.getRequest(reference: reference) { (chapter) in
                    completion(chapter)
                }
                break
        default: break
        }
        
    }
    
}


