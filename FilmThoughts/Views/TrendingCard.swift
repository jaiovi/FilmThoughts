//
//  TrendingCard.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 12/12/24.
//

import SwiftUI

struct TrendingCard: View {
    let movie : MovieItem
    var body: some View {
        ZStack(alignment: .bottom) {
                //poster
                AsyncImage(url: movie.poster_link) { image in
                    image
                        .resizable() // Make the image resizable
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 200) // Define frame size
                        .clipped() // Clip the image to the frame
                        
                }placeholder: {
                    ProgressView()
                }
                VStack {
                    let release_date_cut = movie.release_date.prefix(4)
                    Text("\(movie.title) (\(release_date_cut))")
                        .font(.headline)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
            
        }
        .cornerRadius(10)
        .padding()
        .frame(maxWidth: .infinity)
        
        
    }
        
}
