//
//  TrendingCard.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/12/24.
//

import SwiftUI

struct TrendingCard: View {
    let movie: MovieItem

    var body: some View {
        NavigationLink(destination: AddNoteView(movieTitle: movie.title, movieID: movie.id)) {
            ZStack(alignment: .bottom) {
                // Poster
                AsyncImage(url: movie.poster_link) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }

                VStack {
                    let release_date_cut = movie.release_date.prefix(4)
                    Text("\(movie.title) (\(release_date_cut))")
                        .font(.headline)
                        .padding(10)
                }
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
            }
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
