//
//  ImporterView.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import Factory
import PhotosUI
import SwiftData
import SwiftUI

struct ImporterView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var viewModel: ImporterViewModel

    @Injected(\.appState) var appState: AppStateProtocol

    @Query var importedAssets: [ImportedAsset]

    var body: some View {
        ZStack {
            if importedAssets.count > 0 {
                Color(.white)
                GalleryView()
            } else if appState.state == .importing {
                Color(.black)
                    .ignoresSafeArea()
                VStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2.0)
                        .padding()
                    Text("Importing media...")
                        .font(.title)
                        .foregroundColor(.white)
                }
            } else {
                Color(.black)
                    .ignoresSafeArea()
                Image("Background", bundle: .main)
                    .scaledToFit()
                VStack {
                    HStack(alignment: .bottom) {
                        VStack {
                            Spacer()
                            ImportMediaButton()
                        }
                    }
                }
            }
        }
        .onChange(of: viewModel.selectedItems) { _, _ in
            Task {
                await viewModel.importItems()
                for asset in viewModel.importedAssets {
                    modelContext.insert(asset)
                }
                viewModel.importedAssets = []
            }
        }
    }
}

// Empty state
#Preview {
    let previewer = try? Previewer(items: 0)
    ImporterView()
        .modelContainer(previewer!.container)
        .environmentObject(ImporterViewModel())
}

// Previously imported data
#Preview {
    let previewer = try? Previewer()
    ImporterView()
        .modelContainer(previewer!.container)
        .environmentObject(ImporterViewModel())
}
