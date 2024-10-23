//
//  Previewer.swift
//  avpicker
//
//  Used to inject mock data into SwiftData for Previews
//
//  Created by Will Hannah on 10/22/24.
//

import SwiftData
import SwiftUI

@MainActor
struct Previewer {
    let container: ModelContainer
    let firstUUID: String

    init(items: Int = 10) throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: ImportedAsset.self, configurations: config)

        let image = UIImage(named: "Background")!
        let data = image.pngData()!

        let movie = Movie(url: URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!)
        let video = MediaItem.video(movie)

        var importedAsset = ImportedAsset(mediaItemData: data)
        firstUUID = importedAsset.id.uuidString

        for _ in 0 ..< items {
            importedAsset = ImportedAsset(mediaItemData: data)
            let importedAsset2 = ImportedAsset(from: video)
            container.mainContext.insert(importedAsset)
            container.mainContext.insert(importedAsset)
            container.mainContext.insert(importedAsset2)
        }
    }
}
