//
//  Note
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//

import SwiftUI
import Combine
import WidgetKit

@MainActor
class NotesDBViewModel: ObservableObject {
    @Published var notes: [NoteItem] = [] {
        didSet {
            saveNotes()
            reloadWidget()
        }
    }

    init() {
        loadNotes()
        /*
         private var cancellables = Set<AnyCancellable>()
        // Observe changes to the notes array and print a message when a new note is added
        $notes
            .sink { [weak self] notes in
                print("Notes updated! Current count: \(notes.count)")
                self?.saveNotes() // Save changes to persistence
                self?.reloadWidget() // Reload widget when notes change
            }
            .store(in: &cancellables)
         */
    }

    func addNote(title: String, imageUrl: URL, note: String) {
        downloadImage(from: imageUrl) { [weak self] imageData in
            guard let self = self, let imageData = imageData else { return }
            
            Task { @MainActor in
                let newNote = NoteItem(movieTitle: title, movieImage: imageData, note: note)
                self.notes.append(newNote) // Trigger SwiftUI update
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
    
    private var sharedContainerURL: URL? {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.joviedo24.FilmThoughts")
    }

    private var fileURL: URL {
        sharedContainerURL?.appendingPathComponent("notes.json") ?? URL(fileURLWithPath: "")
    }

    private func loadNotes() {
        guard let fileURL = sharedContainerURL?.appendingPathComponent("notes.json") else { return }
        do {
            let data = try Data(contentsOf: fileURL)
            let decodedNotes = try JSONDecoder().decode([NoteItem].self, from: data)
            notes = decodedNotes
        } catch {
            print("Failed to load notes: \(error.localizedDescription)")
            notes = []
        }
    }

    private func saveNotes() {
        guard let fileURL = sharedContainerURL?.appendingPathComponent("notes.json") else { return }
        do {
            let data = try JSONEncoder().encode(notes)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
        } catch {
            print("Failed to save notes: \(error.localizedDescription)")
        }
    }
    
    // for WidgetKit
    func fetchNotesFromFile() -> [NoteItem] {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            .first!.appendingPathComponent("notes.json")
        
        do {
            let data = try Data(contentsOf: fileURL)
            let notes = try JSONDecoder().decode([NoteItem].self, from: data)
            return notes
        } catch {
            print("Failed to fetch notes: \(error)")
            return []
        }
    }
    
    private func reloadWidget() {
        WidgetCenter.shared.reloadAllTimelines() // Notify WidgetKit to reload widget
    }

}
