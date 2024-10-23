//
//  MediaPlayerView.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import AVKit
import SwiftUI

struct MediaPlayerView: View {
    @State private var player: AVPlayer?
    @State var mediaItem: MediaItem

    var body: some View {
        switch mediaItem {
        case .image(let image):
            ImageAssetView(asset: image)
        case .video(let movie):
            VideoPlayer(player: player)
                .task {
                    await setupPlayer(for: movie)
                }
                .onDisappear {
                    player?.pause()
                }
                .onReceive(NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)) { _ in
                    player?.seek(to: .zero)
                    player?.play()
                }
                .padding(EdgeInsets(top: 50, leading: 10, bottom: 100, trailing: 10))
                .transition(.opacity)
        }
    }

    func setupPlayer(for movie: Movie) async {
        let newPlayer = AVPlayer(url: movie.url)

        await MainActor.run {
            player = newPlayer
            player?.play()
        }
    }
}
