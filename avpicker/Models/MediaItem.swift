//
//  MediaItem.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import SwiftData
import SwiftUI

enum MediaItem: Identifiable {
    case image(UIImage)
    case video(Movie)

    var id: UUID {
        switch self {
        case .image:
            return UUID()
        case .video:
            return UUID()
        }
    }
}
