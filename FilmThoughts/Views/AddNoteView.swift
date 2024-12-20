//
//  AddNoteView.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 16/12/24.
//

import SwiftUI

struct AddNoteView: View {
    let movieTitle: String
    let movieID: Int
    @ObservedObject var notesModel: NotesDBViewModel
    
    @State private var noteContent: String = ""
    @State private var selectedImagePath: String? = nil
    
    @StateObject private var viewModel = MovieImagesViewModel() // ViewModel instance
    
    @Environment(\.dismiss) var dismiss // For dismissing the view
    
    @FocusState private var textEditorIsFocused: Bool
    
    var isDataValid: Bool {
        // Check if both the note content and an image are selected
        return !noteContent.isEmpty && selectedImagePath != nil
    }
    
    var body: some View {
        Form {
            Section(header: Text("Movie Information")) {
                Text(movieTitle)
                    .font(.headline)
                
                Text("Movie ID: \(movieID)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Section(header: Text("Select an Image")) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.filteredImages) { image in
                            let isSelected = selectedImagePath == image.file_path
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(image.file_path)")) { phase in
                                if let loadedImage = phase.image {
                                    loadedImage
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 100)
                                        .cornerRadius(8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 3)
                                        )
                                        .onTapGesture {
                                            selectedImagePath = image.file_path
                                        }
                                        .accessibilityElement(children: .ignore) // Treat as single accessibility element
                                        .accessibilityLabel("Image for movie") // General image description
                                        .accessibilityValue(isSelected ? "Selected" : "Not selected")
                                        .accessibilityAddTraits(.isButton) // Treat image as button for VoiceOver
                                        .accessibilityHint("Double-tap to select this image")
                                } else {
                                    ProgressView()
                                        .frame(width: 150, height: 100)
                                        .accessibilityLabel("Loading image")
                                }
                            }
                        }

                    }
                }
                .frame(height: 120)
            }
            
            Section(header: Text("Add Your Note")) {
                // Changed from textEditor to textField to use onSubmit
                TextField("Write up...", text: $noteContent) //axis: .vertical
                    .focused($textEditorIsFocused)
                    .frame(minHeight: 50)
                    .submitLabel(.done)
                    .onSubmit() {
                        textEditorIsFocused = false
                    }
            }
            
            Section {
                Button(action: saveNote) {
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Text("Save Note")
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .background(isDataValid ? Color.accentColor : Color.gray) // Conditional background color
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .disabled(!isDataValid) // Disable the button if data is invalid
                }
            }
        }
        .navigationTitle("Add Note")
        .onAppear {
            viewModel.loadImages(movie_identifier: movieID)
        }
    }
    
    private func saveNote() {
        guard let selectedPath = selectedImagePath else {
            print("No image selected")
            return
        }
        
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(selectedPath)")!
        
        notesModel.addNote(title: movieTitle, imageUrl: imageURL, note: noteContent)
        dismiss() // Dismiss after saving
    }
}



#Preview {
    let notesViewModel = NotesDBViewModel()
    return AddNoteView(movieTitle: "Wolverine", movieID: 533535, notesModel: notesViewModel)
}

