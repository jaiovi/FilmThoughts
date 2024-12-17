//
//  NoteWidget.swift
//  NoteWidget
//
//  Created by Jesus Sebastian Jaime Oviedo on 17/12/24.
//

import WidgetKit
import SwiftUI

struct NoteEntry: TimelineEntry {
    let date: Date
    let note: NoteItem?
}

// MARK: Provider timeline

struct Provider: TimelineProvider {
    let notes: [NoteItem]

    // Placeholder content for the widget preview
    func placeholder(in context: Context) -> NoteEntry {
        NoteEntry(date: Date(), note: notes.first) // Use the first note
    }

    // Content displayed in the widget when it's in the timeline editor
    func getSnapshot(in context: Context, completion: @escaping (NoteEntry) -> Void) {
        let entry = NoteEntry(date: Date(), note: notes.randomElement())
        completion(entry)
    }

    // Generate a timeline for the widget (once per day)
    func getTimeline(in context: Context, completion: @escaping (Timeline<NoteEntry>) -> Void) {
        let currentDate = Date()
        let midnight = Calendar.current.startOfDay(for: currentDate).addingTimeInterval(86400) // Next day
        let randomNote = notes.randomElement()

        let entry = NoteEntry(date: currentDate, note: randomNote)
        let timeline = Timeline(entries: [entry], policy: .after(midnight))
        completion(timeline)
    }
}

// MARK: Part 2

struct NoteWidgetEntryView: View {
    var entry: Provider.Entry
    @State private var averageColor: Color = .clear

    var body: some View {
        if let note = entry.note {
            // MARK: Inspired by NoteCard.swift
            ZStack(alignment: .bottom) {
                // Convert Data to UIImage and display
                if let uiImage = UIImage(data: note.movieImage) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .clipped() // Ensures the image doesn't overflow
                        .onAppear {
                            // Extract average color when image appears
                            if let color = uiImage.averageColor() {
                                averageColor = Color(color)
                            }
                        }
                } else {
                    Color.gray // Placeholder if image data is invalid
                }

                // Gradient overlay with extracted average color
                LinearGradient(
                    gradient: Gradient(colors: [averageColor.opacity(0.0), averageColor.opacity(0.7)]),
                    startPoint: .center,
                    endPoint: .bottom
                )

                // Movie title text
                VStack(alignment: .leading, spacing: 5) {
                    Text(note.movieTitle)
                        .font(.headline)
                        .foregroundColor(.white)
                        //.padding([.leading, .bottom], 10)
                    Text(note.note)
                        .font(.footnote)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 30, trailing: 15))
            }
            .frame(maxWidth: .infinity) // Full width
        } else {
            Text("No Notes Available")
        }
    }
}

// MARK: Part 3

@main
struct NoteWidget: Widget {
    let kind: String = "NoteWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(notes: loadNotes())) { entry in
            NoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Daily Note Widget")
        .description("Displays a random note from Film Thoughts each day.")
        .supportedFamilies([.systemMedium]) //only medium
        .contentMarginsDisabled() // quit image borders
    }
}

// Helper to load notes synchronously
func loadNotes() -> [NoteItem] {
    guard let sharedContainerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.joviedo24.FilmThoughts") else {
        print("Shared container URL is nil")
        return []
    }
    
    let fileURL = sharedContainerURL.appendingPathComponent("notes.json")
    
    do {
        let data = try Data(contentsOf: fileURL)
        return try JSONDecoder().decode([NoteItem].self, from: data)
    } catch {
        print("Failed to load notes from shared folder: \(error)")
        return []
    }
}

// MARK: Preview

@available(iOS 16.0, *)
struct NoteWidgetPreview: PreviewProvider {
    static var previews: some View {
        // Create a mock NoteItem for the preview
        let mockNote = NoteItem(movieTitle: "Sample Movie", movieImage: UIImage(named: "example_image_note")!.jpegData(compressionQuality: 1.0)! , note: "This is a sample note.")
        
        // Create a mock TimelineEntry
        let mockEntry = NoteEntry(date: Date(), note: mockNote)
        
        // Provide the mock entry to the NoteWidgetEntryView
        NoteWidgetEntryView(entry: mockEntry)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
