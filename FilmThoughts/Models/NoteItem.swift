//
//  Note.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//

import Foundation
import SwiftUI

struct NoteItem : Identifiable {
    let id: UUID = UUID()
    var movieTitle: String
    var movieImage: Data
    var note: String
}
