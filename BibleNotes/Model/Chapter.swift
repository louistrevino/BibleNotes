//
//  Chapter.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/5/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import Foundation

struct Chapter : Decodable {
    enum Category: String, Decodable {
        case swift, combine, debugging, xcode
    }

    let title: String
    let url: URL
    let category: Category
    let views: Int
}
