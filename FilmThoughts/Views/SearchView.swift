//
//  SearchView.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//

// TODO: Implement search

import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""
    @State var viewModel = MovieDBViewModel()
    
    var body: some View {
        NavigationStack {
            Text("Search")
                .font(.largeTitle)
        }
        .searchable(text: $searchText)
        .onSubmit {
            viewModel.loadSearch(searchTitle: searchText, searchPage: 1)
        }
    }
}

#Preview {
    SearchView()
}
