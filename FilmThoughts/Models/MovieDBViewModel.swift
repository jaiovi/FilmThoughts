//
//  MovieDBViewModel.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 09/12/24.
//

import Foundation
import SwiftUI

@MainActor
class MovieDBViewModel: ObservableObject  {
    @Published var trending: [MovieItem] = []
    
    /*
    enum TrendingState {
        case none
        case loading
        case error(message: String)
        case trendingItems([MovieItem])
    }
    */
    
    func loadTrending() {
        Task {
           //crear un request
            //https://www.swiftbysundell.com/articles/constructing-urls-in-swift/
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week?api_key=\(Keys.tmdbApiToken)")!
            
            do {
                //makes call
                let (data, _) = try await URLSession.shared.data(from: url)
                //check what code did url call gave us
                /*
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                if 200..<300 ~= statusCode ?? 0 {
                    print("Success")
                } else {
                    print("Error")
                }
                 */
                //parses JSON to object
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                //saves the data
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct TrendingResults :  Decodable {
    let page: Int
    let results: [MovieItem] //results to save
    let total_pages: Int
    let total_results: Int
}

struct MovieItem : Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let release_date: String
}
