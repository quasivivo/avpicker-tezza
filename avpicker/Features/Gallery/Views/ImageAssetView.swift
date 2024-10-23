//
//  ImageAssetView.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import SwiftUI

struct ImageAssetView: View {
    @State var dimension: CGFloat?

    let asset: UIImage?

    @State private var loadedImage: UIImage? = nil

    var body: some View {
        Group {
            if let image = loadedImage, let dimension = dimension {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: dimension, height: dimension)
                    .clipped()
                    .cornerRadius(8)
            } else if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding(10)
                    .transition(.opacity)
            } else if asset == nil {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: dimension, height: dimension)
                    .clipped()
                    .cornerRadius(8)
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }

    private func loadImage() {
        guard loadedImage == nil else { return }

        DispatchQueue.global(qos: .background).async {
            let image = asset
            DispatchQueue.main.async {
                self.loadedImage = image
            }
        }
    }
}

#Preview {
    let sampleimageURL = URL(string: "https://www.shoptezza.com/cdn/shop/files/TEZZA-LOGO-2_120x@2x.png?v=1614031128")!
    let image = UIImage(data: try! Data(contentsOf: sampleimageURL))!
    ImageAssetView(dimension: 110, asset: image)
}
