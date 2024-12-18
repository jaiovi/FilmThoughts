//
//  ContentView.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 09/12/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var notesViewModel = NotesDBViewModel()

    var body: some View {
        TabView {
            Tab("Notes", systemImage: "books.vertical.fill"){
                HomeView(notesViewModel: notesViewModel)
            }
            Tab("Trending", systemImage: "chart.line.uptrend.xyaxis"){
                TrendingView(notesViewModel: notesViewModel)
            }
            /*
            HomeView(notesViewModel: notesViewModel)
                .tabItem {
                    Label("Notes", systemImage: "books.vertical.fill")
                }
            TrendingView(notesViewModel: notesViewModel)
                .tabItem {
                    Label("Trending", systemImage: "chart.line.uptrend.xyaxis")
                }
             */
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ContentView()
}
