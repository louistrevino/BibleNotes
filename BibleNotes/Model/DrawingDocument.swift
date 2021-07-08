//
//  DrawingDocument.swift
//  BibleNotes
//
//  Created by Louis Trevino on 6/29/21.
//  Copyright © 2021 Louis Trevino. All rights reserved.
//

import Foundation

struct DrawingDocument : Identifiable {
    let id : UUID
    var data : Data
    var name : String
    var book : String
    var chapter : Int32
}
