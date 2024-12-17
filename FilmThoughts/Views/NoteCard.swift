//
//  NoteCard.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//

import SwiftUI

struct NoteCard: View {
    let note: NoteItem
    @State private var averageColor: Color = .clear

    var body: some View {
        ZStack(alignment: .bottom) {
            // Convert Data to UIImage and display
            if let uiImage = UIImage(data: note.movieImage) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .onAppear {
                        // Extract average color when image appears
                        if let color = uiImage.averageColor() {
                            averageColor = Color(color)
                        }
                    }
            } else {
                Color.gray // Placeholder if image data is invalid
            }

            // Gradient overlay with extracted average color
            LinearGradient(
                gradient: Gradient(colors: [averageColor.opacity(0.0), averageColor.opacity(0.7)]),
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(height: 150, alignment: .bottom)

            // Movie title text
            VStack(alignment: .leading, spacing: 5) {
                Text(note.movieTitle)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding([.leading, .bottom], 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .cornerRadius(10) // Round corners
        .padding() // Padding around the card
        .frame(maxWidth: .infinity) // Full width
    }
}

#Preview {
    NoteCard(note: NoteItem(
        movieTitle: "Sample Movie",
        movieImage: (UIImage(named: "example_image_note")?.pngData())!,
        note: "Sample Note"
    ))
}