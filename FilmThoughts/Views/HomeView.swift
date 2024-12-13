//
//  HomeView.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = NotesDBViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    NoteCard(note: note)
                        .swipeActions(edge: .trailing) { // Add swipe, only available for List
                            
                            Button {
                                //put view to delete, with state functions
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            
                            Button(role: .destructive) {
                                viewModel.removeNote(note: note)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }

                            
                        }
                }
            }
            .listStyle(PlainListStyle()) //quit ugly background
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        // Code to add a new note
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
