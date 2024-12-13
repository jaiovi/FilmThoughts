//
//  TrendingView.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//

import SwiftUI

struct TrendingView: View {
    // call the builder
    @StateObject var viewModel = MovieDBViewModel()
    
    var body: some View {
        VStack {
            VStack {
                Text("Trending Movies")
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
        .onAppear {
            viewModel.loadTrending()
        }
    }
}

#Preview {
    TrendingView()
}
