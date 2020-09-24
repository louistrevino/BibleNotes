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
        chapter = Chapter()
        nextChapter = []
        prevChapter = []
        canonical = ""
    }
    func getRequest(reference: String){

        var request = URLRequest(url: URL(string: "https://api.esv.org/v3/passage/html/?q=" + reference + "&include-passage-references=false" +
            "&include-footnotes=false" +
            "&horizontal-line-length=30" +
            "&include-heading-horizontal-lines=true" +
            "&include-passage-horizontal-lines=false" +
            "&include-headings=false"
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
                
                // insert scanner here for verses
//                self.versesText = json.passages[0].components(separatedBy: "[")
                var i = 0
                print("===============VERSE TEXT==============\n" + json.passages[0]
                    + "\n===========END VERSE TEXT ==============\n")
//                for verse in json.passages[0].components(separatedBy: "[") {
//                    self.chapter.verses?.append(VerseObject())
//                    self.chapter.verses?[i].text = verse
//                    i+=1
//                    self.chapter.verses?[i].verseNumber = String(i)
//                }
//
                let htmlData = NSString(string: json.passages[0]).data(using: String.Encoding.unicode.rawValue)
                let options = [NSAttributedString.DocumentReadingOptionKey.documentType:
                        NSAttributedString.DocumentType.html]
                let attributedString = try? NSMutableAttributedString(data: htmlData ?? Data(),
                                                                          options: options,
                                                                          documentAttributes: nil)
                self.chapter.verses![0].text = attributedString!.string
                
            } catch {
                print(error)
            }

        }
        task.resume()
    }
    
}
