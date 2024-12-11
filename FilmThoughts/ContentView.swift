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
            if(viewModel.trending.isEmpty){
                Text("No results")
            }
            else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.trending) { movie in
                            TrendingCard(movie: movie)
                        }
                    }
                }
            }
            
            
        }
        .padding()
        .onAppear {
            viewModel.loadTrending()
        }
    }
}

struct TrendingCard: View {
    let movie : MovieItem
    var body: some View {
        ZStack {
            //poster
            /*
            AsyncImage(url: URL(movie.poster_path)) { image in
                image
                    .resizable()
                    .scaledToFill()
            }placeholder: {
                ProgressView()
            }
             */
            
        }
        VStack {
            let release_date_cut = movie.release_date.prefix(4)
            Text("\(movie.title) (\(release_date_cut))")
                .font(.headline)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
