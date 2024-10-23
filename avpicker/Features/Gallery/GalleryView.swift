//
//  GalleryView.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import AVFoundation
import Factory
import SwiftData
import SwiftUI

struct GalleryView: View {
    @Injected(\.galleryViewModel) private var viewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.modelContext) private var modelContext

    @State private var showingViewer = false
    @State private var showingDeleteConfirmation = false
    @State private var columns: [GridItem] = []

    @Query var importedAssets: [ImportedAsset]

    var body: some View {
        ZStack {
            Color(red: 249/255, green: 237/255, blue: 221/255)
                .ignoresSafeArea()
            VStack {
                Image("GalleryHeader", bundle: .main)
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(importedAssets.indices, id: \.self) { index in
                            Group {
                                switch importedAssets[index].mediaType {
                                case .image(let image):
                                    ImageAssetView(dimension: 110, asset: image)
                                        .padding()
                                case .video(let movie):
                                    VideoThumbnailView(movie: movie)
                                        .padding()
                                case .none:
                                    EmptyView()
                                }
                            }.onTapGesture(count: 2) {
                                viewModel.selectMedia(importedAssets[index])
                                showingViewer.toggle()
                            }
                            .onLongPressGesture {
                                viewModel.selectMedia(importedAssets[index])
                                showingDeleteConfirmation.toggle()
                            }
                        }
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 20)
                }.offset(y: -50)
                VStack {
                    Image("EditingTools", bundle: .main)
                        .resizable()
                        .scaledToFit()
                        .ignoresSafeArea()
                }
            }
            .confirmationDialog("Delete this item?", isPresented: $showingDeleteConfirmation) {
                Button("Delete", role: .destructive) {
                    guard let selectedMediaItem = viewModel.selectedMediaItem else { return }
                    modelContext.delete(selectedMediaItem)
                    showingDeleteConfirmation = false
                }
                Button("Cancel", role: .cancel) {
                    showingDeleteConfirmation = false
                }
            }
            .fullScreenCover(isPresented: $showingViewer) {
                if viewModel.selectedMediaItem == nil {
                    EmptyView()
                } else {
                    ViewerView(isPresented: $showingViewer, selectedMedia: viewModel.selectedMediaItemId)
                }
            }
            .onAppear {
                calculateColumns()
            }
            .onChange(of: horizontalSizeClass) { _, _ in
                calculateColumns()
            }
        }
    }

    private func calculateColumns() {
        var cols = [GridItem(.flexible()), GridItem(.flexible())]
        if horizontalSizeClass == .compact {
            cols.append(GridItem(.flexible()))
        }
        columns = cols
    }
}

#Preview {
    let previewer = try? Previewer()
    GalleryView()
        .modelContainer(previewer!.container)
}
