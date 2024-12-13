//
//  Images.swift
//  FilmThoughts
//
//  Created by Jesus Sebastian Jaime Oviedo on 13/12/24.
//

import Foundation
import UIKit

func saveImageToDocumentsDirectory(image: UIImage, fileName: String) -> URL? {
    guard let data = image.jpegData(compressionQuality: 1.0) else { return nil }
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
    
    do {
        try data.write(to: fileURL)
        return fileURL
    } catch {
        print("Error saving image: \(error)")
        return nil
    }
}

func loadImageFromDocumentsDirectory(fileName: String) -> UIImage? {
    let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
    
    if let data = try? Data(contentsOf: fileURL) {
        return UIImage(data: data)
    }
    return nil
}
