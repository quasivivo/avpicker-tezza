//
//  ImporterViewModel.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import Factory
import PhotosUI
import SwiftData
import SwiftUI

enum ImporterWorkflowState {
    case idle
    case picking
    case importing
    case imported
}

final class ImporterViewModel: ObservableObject {
    @Injected(\.appState) private var appState: AppStateProtocol
    @Published var selectedItems: [PhotosPickerItem] = []

    @Published var importedAssets: [ImportedAsset] = []

    func importItems() async {
        appState.transition(to: .importing)

        await withTaskGroup(of: MediaItem?.self) { group in
            for newItem in selectedItems {
                if Task.isCancelled { return }

                group.addTask {
                    guard !Task.isCancelled else { return nil }

                    do {
                        if let movie = try await newItem.loadTransferable(type: Movie.self) {
                            print("Processed movie: \(movie.url)")
                            return .video(movie)
                        } else if let data = try await newItem.loadTransferable(type: Data.self),
                                  let image: UIImage = .init(data: data)
                        {
                            print("Processed image: \(image)")
                            return .image(image)
                        }

                        throw PhotosPickerError.unableToLoadItem
                    } catch {
                        print("Error loading item: \(error)")
                    }

                    return nil
                }
            }
            for await result in group {
                if let image = result {
                    await MainActor.run {
                        importedAssets.append(ImportedAsset(from: image))
                    }
                }
            }
        }

        appState.transition(to: .imported)
    }
}
