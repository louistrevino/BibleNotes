//
//  ContentView.swift
//  BibleNotes
//
//  Created by Louis Trevino on 4/5/20.
//  Copyright © 2020 Louis Trevino. All rights reserved.
//

import SwiftUI
import PencilKit


struct ContentView: View {
    
    @ObservedObject var translationManager = TranslationManager()
    @ObservedObject var vars = Vars()
    @ObservedObject var manager = DrawingManager(book: "john", chapter: 1)

    var body: some View {
        NavigationView {
            ListItemView(vars: vars).environmentObject(translationManager).environmentObject(manager)
                .navigationTitle("Books")
            DetailsView(translationManager: translationManager, vars: vars, manager: manager)
                .navigationBarItems(trailing: NavMenuView(translationManager: translationManager, vars: vars, manager: manager))
        }
        .onAppear{
            self.translationManager.getPassage(reference: "john1", translation: Translations.ESV, completion: { chapter in
                self.vars.reference = chapter.reference
                self.vars.verses = chapter.verses
            })
        }

    }
}
