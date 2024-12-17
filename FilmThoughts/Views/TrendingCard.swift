//
//  TrendingCard.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/12/24.
//

import SwiftUI

struct TrendingCard: View {
    let movie: MovieItem
    let notesViewModel: NotesDBViewModel // Accept the shared NotesDBViewModel

    var body: some View {
        NavigationLink(destination: AddNoteView(movieTitle: movie.title, movieID: movie.id, notesModel: notesViewModel)) {
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

#Preview {
    let notesViewModel = NotesDBViewModel()
    let sampleMovie = MovieItem(adult: true, id: 345234, poster_path: "/lECA3TxwjTOjjMqjvUe9kBarmM9.jpg", title: "Wolverine", release_date: "2020-05-30")

    TrendingCard(movie: sampleMovie, notesViewModel: notesViewModel)
}
