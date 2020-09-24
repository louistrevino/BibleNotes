//
//  Chapter.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/5/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import Foundation

struct Chapter : Hashable {

    public var verses : [VerseObject]?
    
    init(){
        verses = [VerseObject()]
    }
}
