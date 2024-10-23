//
//  PageContentView.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import SwiftUI

struct PageContentView: View {
    let asset: ImportedAsset?

    @Binding var currentMedia: String?

    var body: some View {
        VStack {
            if let asset = asset?.mediaType {
                MediaPlayerView(mediaItem: asset)
                    .transition(.opacity)
            } else {
                Color.gray
            }
        }
    }
}
