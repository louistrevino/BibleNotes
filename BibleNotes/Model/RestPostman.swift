//
//  RestPostman.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/11/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import Foundation

class RestPostman {

    public var versesText : [String]
    let decoder = JSONDecoder()
    
    
    init() {
        versesText = []
    }
    func getRequest(){
        let semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "https://api.esv.org/v3/passage/text/?q=John+1&include-passage-references=false" +
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
            semaphore.signal()
            do {
                print(String(data: data, encoding: .ascii))
                let decoder = JSONDecoder()
                let verse = try decoder.decode(Verse.self, from: data)
                print("-------- VERSE -------")
                print(verse.passages)
                self.versesText = verse.passages
            } catch {
                print(error)
            }

        }

        task.resume()
        semaphore.wait()
    }
    
}
