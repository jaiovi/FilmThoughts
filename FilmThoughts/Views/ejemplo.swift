//
//  ejemplo.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//
/*
 struct SearchView: View {
 @State var searchText: String = ""
 @StateObject var viewModel = MovieDBViewModel()
 @StateObject var notesViewModel = NotesViewModel() // Create an instance of NotesViewModel
 
 var body: some View {
 NavigationStack {
 VStack {
 Text("Search")
 .font(.largeTitle)
 
 ScrollView {
 ForEach(viewModel.trending) { movie in
 VStack {
 TrendingCard(movie: movie)
 Button(action: {
 notesViewModel.addNote(title: movie.title, image: movie.poster_link)
 }) {
 Text("Save Note")
 .font(.headline)
 .foregroundColor(.blue)
 }
 }
 }
 }
 
 NavigationLink("View Notes") {
 NotesView()
 .environmentObject(notesViewModel)
 }
 .padding(.top)
 }
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
 */
