//
//  TrendingView.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//

import SwiftUI

import SwiftUI

struct TrendingView: View {
    @StateObject var viewModel = MovieDBViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.trending.isEmpty {
                    Text("No results")
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 20) { // Use LazyVStack for efficient scrolling
                            ForEach(viewModel.trending) { movie in
                                TrendingCard(movie: movie)
                            }
                        }
                        .padding()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.background)
            .navigationTitle("Trending")
            .onAppear {
                viewModel.loadTrending()
            }
        }
    }
}

#Preview {
    TrendingView()
}
