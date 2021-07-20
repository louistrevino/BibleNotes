//
//  ESVWebService.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/11/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import Foundation
import SwiftUI

class ESVWebService : ObservableObject {
    
    private let decoder = JSONDecoder()
    
    private let TOKEN = "56785c18d9889f1740364b845f4a6b09fb71e695"

    func getRequest(reference: String, completion: @escaping (Chapter) -> ()){

        var request = URLRequest(url: URL(string: "https://api.esv.org/v3/passage/text/?q=" + reference + "&include-passage-references=false" +
            "&include-footnotes=false" +
            "&horizontal-line-length=30" 
        )!,timeoutInterval: Double.infinity)
        request.addValue("Token " + TOKEN, forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            do {
                let decoder = JSONDecoder()
                let json = try decoder.decode(ESVData.self, from: data)
                DispatchQueue.main.async {
                    completion(self.parseESVData(data: json))
                }
            } catch {
                print(error)
            }

        }
        task.resume()
    }
    
    func parseESVData(data: ESVData) -> Chapter {
        var esvReturnData = Chapter(reference: data.canonical, verses: [Verse]())
        let separators = CharacterSet(charactersIn: "[]")
        let parts = data.passages[0].components(separatedBy: separators)
        var verseNumbers = [Int]()
        var verseTexts = [String]()
        var header = [String]()

        for substring in parts {
            guard let s = Int(substring) else {
                if verseNumbers.count > 0 {
                    verseTexts.append(substring)
                } else {
                    header.append(substring)
                }
                continue
            }
            verseNumbers.append(s)
        }
        
        for i in 0 ..< verseNumbers.count {
            esvReturnData.verses.append(Verse(number: verseNumbers[i], text: verseTexts[i]))
        }
        
        return esvReturnData
    }
    
}
