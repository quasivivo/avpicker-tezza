//
//  GalleryViewModel.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import SwiftData
import SwiftUI

protocol GalleryViewModelProtocol {
    func selectMedia(_ mediaItem: ImportedAsset)
}

final class GalleryViewModel: ObservableObject, GalleryViewModelProtocol {
    @Published var selectedMediaItem: ImportedAsset? = nil

    var selectedMediaItemId: String {
        selectedMediaItem?.id.uuidString ?? ""
    }

    func selectMedia(_ mediaItem: ImportedAsset) {
        selectedMediaItem = mediaItem
    }
}
