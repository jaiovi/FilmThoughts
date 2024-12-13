//
//  ContentView.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 09/12/24.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        TabView {
            Tab("Home", systemImage: "books.vertical.fill") {
                HomeView()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
