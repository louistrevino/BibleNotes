//
//  VersesDao.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/5/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import Foundation

struct Verse: Codable {
    
    let query : String?
    let canonical : String?
    let parsed : [[Int]]
    let passage_meta : [PassageMeta]
    let passages : [String]

}

struct PassageMeta : Codable {
    var canonical : String?
    var chapter_start : [Int]
    var chapter_end : [Int]
    var next_verse : Int?
    var prev_verse : Int?
    var prev_chapter : [Int]
    var next_chapter : [Int]
}
