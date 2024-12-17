//
//  Note
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//

import SwiftUI
import Combine

@MainActor
class NotesDBViewModel: ObservableObject {
    @Published var notes: [NoteItem] = []
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadNotes()

        // Observe changes to the notes array and print a message when a new note is added
        $notes
            .sink { notes in
                print("Notes updated! Current count: \(notes.count)")
            }
            .store(in: &cancellables)
    }

    func addNote(title: String, imageUrl: URL, note: String) {
        downloadImage(from: imageUrl) { [weak self] imageData in
            guard let imageData = imageData else { return }

            DispatchQueue.main.async {
                let newNote = NoteItem(movieTitle: title, movieImage: imageData, note: note)
                self?.notes.append(newNote)
            }
        }
    }

    // Function to remove a note
    func removeNote(note: NoteItem) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes.remove(at: index)
        }
    }

    // Helper function to download an image from URL
    /*
    private func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                completion(data)
            } else {
                print("Failed to download image: \(String(describing: error))")
                completion(nil)
            }
        }.resume()
    }
     */
    // less clunky solution
    private func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            completion(data)
        }.resume()
    }
    
    private func loadNotes() {
        // For example, load sample notes (replace with your persistence logic)
        notes = [
            NoteItem(movieTitle: "Sample Movie 1", movieImage: UIImage(named: "example_image_note")!.jpegData(compressionQuality: 1.0)!, note: "Sample note 1"),
            NoteItem(movieTitle: "Sample Movie 2", movieImage: UIImage(named: "example_image_note")!.jpegData(compressionQuality: 1.0)!, note: "Sample note 2")
        ]
    }
}
