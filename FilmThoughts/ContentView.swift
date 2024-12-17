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
            Tab("Notes", systemImage: "books.vertical.fill") {
                HomeView()
            }
            Tab("Trending", systemImage: "chart.line.uptrend.xyaxis") {
                TrendingView()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
