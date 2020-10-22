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
    
    var body: some View {
        NavigationView {
            ListItemView().environmentObject(restP)
                .navigationTitle("Books")
            DetailsView(restP: restP, vars: vars)
                .navigationBarItems(trailing: NavMenuView(restP: restP, vars: vars))
        }

    }
}
