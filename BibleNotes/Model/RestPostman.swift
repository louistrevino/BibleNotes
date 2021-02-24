//
//  RestPostman.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/11/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import Foundation
import SwiftUI

class RestPostman : ObservableObject {

    @Published public var versesText : [String]
    @Published public var nextChapter: [Int]
    @Published public var prevChapter: [Int]
    @Published public var canonical : String
    let decoder = JSONDecoder()
    
    init() {
        versesText = []
        nextChapter = []
        prevChapter = []
        canonical = ""
    }
    func getRequest(reference: String){

        var request = URLRequest(url: URL(string: "https://api.esv.org/v3/passage/html/?q=" + reference + "&include-passage-references=false" +
            "&include-footnotes=false" +
            "&horizontal-line-length=30" 
        )!,timeoutInterval: Double.infinity)
        request.addValue("Token 56785c18d9889f1740364b845f4a6b09fb71e695", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(Verse.self, from: data)
                DispatchQueue.main.async {
                    self.canonical = json.canonical ?? ""
                    self.versesText = json.passages
                    self.prevChapter = json.passage_meta[0].prev_chapter
                    self.nextChapter = json.passage_meta[0].next_chapter
                }
            } catch {
                print(error)
            }

        }
        task.resume()
    }
    
}
