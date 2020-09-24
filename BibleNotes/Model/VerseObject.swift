//
//  VerseObject.swift
//  BibleNotes
//
//  Created by Louis Trevino on 8/16/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import Foundation

struct VerseObject : Hashable {
//    var id : UUID
    public var verseNumber : String = ""
    public var text : String = ""
    public var isClicked = false
    
    init(){
        verseNumber = ""
        text = ""
    }
    
}
