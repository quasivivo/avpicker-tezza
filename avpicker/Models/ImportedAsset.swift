//
//  ImportedAsset.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import SwiftData
import SwiftUI

@Model
final class ImportedAsset {
    var id: UUID
    var mediaItemData: Data
    var timestamp: Date

    var mediaType: MediaItem? {
        if let image = UIImage(data: mediaItemData) {
            return .image(image)
        } else if let url = URL(dataRepresentation: mediaItemData, relativeTo: nil) {
            let movie = Movie(url: url)
            return .video(movie)
        }
        return nil
    }

    init(mediaItemData: Data, id: UUID = UUID(), timestamp: Date = Date()) {
        self.id = id
        self.mediaItemData = mediaItemData
        self.timestamp = timestamp
    }

    init(from mediaItem: MediaItem) {
        switch mediaItem {
        case .image(let image):
            self.mediaItemData = image.pngData()!
        case .video(let movie):
            self.mediaItemData = movie.url.dataRepresentation
        }

        self.id = UUID()
        self.timestamp = Date()
    }
}
