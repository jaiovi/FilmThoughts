//
//  ContentView.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 09/12/24.
//

import SwiftUI

struct ContentView: View {
    // call the builder
    @StateObject var viewModel = MovieDBViewModel()
    
    var body: some View {
        VStack {
            
        }
        .padding()
        .onAppear {
            viewModel.loadTrending()
        }
    }
}

#Preview {
    ContentView()
}
