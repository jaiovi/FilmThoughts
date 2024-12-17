//
//  SearchView.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//

// NOT IMPLEMENTED

import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""
    @State var viewModel = MovieDBViewModel()
    
    var body: some View {
        NavigationStack {
            Text("Search")
                .font(.largeTitle)
            /*
             // I want to try this
            if(viewModel.loadSearch!=null) {
                ScrollView {
                    
                }
            }
             */
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
