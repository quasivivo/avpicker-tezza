//
//  Container.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import Factory
import SwiftUI

// Simple container to demo usage for app settings and some view models
extension Container {
    var appState: Factory<AppStateProtocol> {
        self { AppState() }.singleton
    }

    var galleryViewModel: Factory<GalleryViewModel> {
        self { GalleryViewModel() }.singleton
    }
}
