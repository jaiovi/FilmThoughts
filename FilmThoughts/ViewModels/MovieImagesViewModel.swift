//
//  MovieImagesViewModel.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 16/12/24.
//

import Foundation

@MainActor
class MovieImagesViewModel: ObservableObject {
    @Published var images: [ImageItem] = []
    @Published var filteredImages: [ImageItem] = []
    
    func loadImages(movie_identifier: Int) {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie_identifier)/images?api_key=\(Keys.tmdbApiToken)")!
            
            do {
                // Fetch data
                let (data, _) = try await URLSession.shared.data(from: url)
                // Decode the response
                let response = try JSONDecoder().decode(ImageResponse.self, from: data)
                // Assign the backdrops array to images
                images = response.backdrops
                
                // Filter and take first 10 with aspect ratio 1.778
                filteredImages = response.backdrops
                    .filter { $0.aspect_ratio == 1.778 }
                    .prefix(10)
                    .map { $0 }
            } catch {
                print("Error loading images: \(error.localizedDescription)")
            }
        }
    }
}


struct ImageItem: Decodable, Identifiable {
    let id = UUID() // Make it identifiable for SwiftUI lists
    let aspect_ratio: Double
    let file_path: String
    
    enum CodingKeys: String, CodingKey {
        case aspect_ratio
        case file_path
    }
}

struct ImageResponse: Decodable { //loads only backdrops this loader
    let backdrops: [ImageItem]
}

