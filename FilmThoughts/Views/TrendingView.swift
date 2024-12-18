//
//  TrendingView.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//

import SwiftUI

struct TrendingView: View {
    @StateObject var viewModel = MovieDBViewModel()
    @ObservedObject var notesViewModel: NotesDBViewModel // Shared NotesDBViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.trending.isEmpty {
                    Text("No results")
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.trending) { movie in
                                TrendingCard(movie: movie, notesViewModel: notesViewModel)
                            }
                        }
                        .padding()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Trending")
            .onAppear {
                viewModel.loadTrending()
            }
        }
    }
}

#Preview {
    let notesViewModel = NotesDBViewModel()
    TrendingView(notesViewModel: notesViewModel)
}
