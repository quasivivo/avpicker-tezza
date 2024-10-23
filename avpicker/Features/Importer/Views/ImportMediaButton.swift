//
//  ImportMediaButton.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import Factory
import PhotosUI
import SwiftUI

struct ImportMediaButton: View {
    @EnvironmentObject var viewModel: ImporterViewModel

    var body: some View {
        PhotosPicker(
            selection: $viewModel.selectedItems,
            matching: .any(of: [.images, .videos]),
            photoLibrary: .shared()
        ) {
            HStack {
                Text("Import your media")
                    .padding(15)
                    .background(.white)
                    .foregroundStyle(.black)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(30)

                Image(systemName: "plus")
                    .font(.title)
                    .padding(8)
                    .background(.yellow)
                    .cornerRadius(100)
            }
        }
        .onAppear {
            viewModel.selectedItems = []
        }
        .foregroundStyle(.black)
        .buttonStyle(.plain)
        .padding(.bottom, 30)
    }
}

#Preview {
    let previewer = try? Previewer()
    ImportMediaButton()
        .environmentObject(ImporterViewModel())
}
