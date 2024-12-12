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
            VStack {
                Text("Hello, World!")
                    .font(.title)
                    .fontWeight(.heavy)
                //shows the list
                if(viewModel.trending.isEmpty) {
                    Text("No results")
                } else {
                    ScrollView {
                        ForEach(viewModel.trending) { movie in
                            TrendingCard(movie: movie)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.background)
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.loadTrending()
        }

        
    }
}

#Preview {
    ContentView()
}
