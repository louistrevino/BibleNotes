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
    
    @ObservedObject var restP = RestPostman()
    @ObservedObject var vars = Vars()
    @ObservedObject var manager = DrawingManager(book: "john", chapter: 1)

    var body: some View {
        NavigationView {
            ListItemView(vars: vars).environmentObject(restP).environmentObject(manager)
                .navigationTitle("Books")
            DetailsView(restP: restP, vars: vars, manager: manager)
                .navigationBarItems(trailing: NavMenuView(restP: restP, vars: vars, manager: manager))
        }

    }
}
