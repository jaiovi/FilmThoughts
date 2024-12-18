//
//  MovieDBViewModel.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 09/12/24.
//

/*
enum TrendingState {
    case none
    case loading
    case error(message: String)
    case trendingItems([MovieItem])
}
*/

import Foundation
import SwiftUI

@MainActor
class MovieDBViewModel: ObservableObject  {
    @Published var trending: [MovieItem] = []
    
    func loadTrending() {
        Task {
           //crear un request
            //https://www.swiftbysundell.com/articles/constructing-urls-in-swift/
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/week?api_key=\(Keys.tmdbApiToken)")!
            
            do {
                //makes call
                let (data, _) = try await URLSession.shared.data(from: url)
                //parses JSON to object
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                //saves the data
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // TODO: Create SearchView.swift and connect
    func loadSearch(searchTitle: String, searchPage: Int) {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/search/movie")!
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            let queryItems: [URLQueryItem] = [
              URLQueryItem(name: "query", value: searchTitle),
              URLQueryItem(name: "include_adult", value: "false"),
              URLQueryItem(name: "page", value: "\(searchPage)"),
            ]
            components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = [
              "accept": "application/json",
              "Authorization": Keys.tmdbApiBearer
            ]

            let (data, _) = try await URLSession.shared.data(for: request)
            print(String(decoding: data, as: UTF8.self))
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
    //let poster_path: String
    let backdrop_path: String
    let title: String
    let release_date: String
    
    var backdrop_link: URL {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w300")!
        return baseURL.appendingPathComponent(backdrop_path)
    }
}
