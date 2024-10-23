//
//  VideoThumbnailView.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import AVKit
import SwiftUI

struct VideoThumbnailView: View {
    @State private var thumbnailImage: UIImage?
    let movie: Movie

    var body: some View {
        VStack {
            if let thumbnailImage = thumbnailImage {
                Image(uiImage: thumbnailImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 110)
                    .clipped()
                    .cornerRadius(8)
            } else {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 110, height: 110)
                    .cornerRadius(8)
                    .overlay(ProgressView())
            }
        }
        .task {
            await loadThumbnailImage()
        }
    }

    private func loadThumbnailImage() async {
        do {
            thumbnailImage = try await getThumbnailImage(forUrl: movie.url)
        } catch {
            print("Error loading thumbnail image: \(error)")
        }
    }

    private func getThumbnailImage(forUrl url: URL) async throws -> UIImage {
        let asset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        return try await withCheckedThrowingContinuation { continuation in
            let time = CMTimeMake(value: 1, timescale: 60)
            imageGenerator.appliesPreferredTrackTransform = true

            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let thumbnailImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                    let uiImage = UIImage(cgImage: thumbnailImage)
                    continuation.resume(returning: uiImage)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
