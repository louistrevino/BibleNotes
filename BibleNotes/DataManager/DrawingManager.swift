//
//  DrawingManager.swift
//  BibleNotes
//
//  Created by Louis Trevino on 7/1/21.
//  Copyright © 2021 Louis Trevino. All rights reserved.
//

import SwiftUI

class DrawingManager: ObservableObject {
    @Published var docs: [DrawingDocument]
    
    init(book: String, chapter: Int32) {
        docs = CoreDataManager.shared.getDataForPassage(book: book, chapter: chapter)
    }
    
    func updateReference(book: String, chapter: Int32) {
        docs = CoreDataManager.shared.getDataForPassage(book: book, chapter: chapter)
    }
    
    func update(data: Data, for id: UUID) {
        if let index = self.docs.firstIndex(where: {$0.id == id}) {
            self.docs[index].data = data
            CoreDataManager.shared.updateData(data: self.docs[index])
        }
    }
    
    func getData(for id: UUID) -> Data {
        if let doc = self.docs.first(where: {$0.id == id}) {
            return doc.data
        }
        return Data()
    }
    
    func getDataByReference(book: String, chapter: Int32) -> Data {
        if let doc = self.docs.first(where: {$0.book == book && $0.chapter == chapter}) {
            return doc.data
        }
        return Data()
    }
    
    func addData(doc: DrawingDocument) {
        docs.append(doc)
        CoreDataManager.shared.addData(doc: doc)
    }
    
    func delete(for indexSet: IndexSet) {
        for index in indexSet {
            CoreDataManager.shared.deleteData(data: docs[index])
            docs.remove(at: index)
        }
    }
}
