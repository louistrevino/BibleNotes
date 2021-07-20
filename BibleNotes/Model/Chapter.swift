//
//  Chapter.swift
//  BibleNotes
//
//  Created by Louis Trevino on 7/10/21.
//  Copyright © 2021 Louis Trevino. All rights reserved.
//

import Foundation

//struct Chapter {
//    var reference : Int32
//    var book : String
////    var verses : [Verse]
//    var totalVerses : Int
//}

struct Verse : Identifiable {
    let id = UUID()
    let number : Int
    let text : String
}

struct Chapter {
    var reference : String
    var verses : [Verse]
}
