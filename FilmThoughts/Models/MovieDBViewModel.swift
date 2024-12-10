//
//  MovieDBViewModel.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 09/12/24.
//

import Foundation
import SwiftUI

class MovieDBViewModel: ObservableObject  {
    @Published var homeScreen: [MovieItem] = []
    
    func loadTrending() {
        Task {
           //crear un request
            
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week?api_key=a1b2c3d4")!
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        }
    }
}

struct MovieItem : Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let release_date: String
}
