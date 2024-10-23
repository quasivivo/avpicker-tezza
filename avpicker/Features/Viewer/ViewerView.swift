//
//  ViewerView.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import Factory
import SwiftData
import SwiftUI

struct ViewerView: View {
    @Binding var isPresented: Bool
    @State var selectedMedia: String?

    @Query var importedAssets: [ImportedAsset]

    var body: some View {
        ZStack {
            Color(red: 249/255, green: 237/255, blue: 221/255)
                .ignoresSafeArea()
            TabView(selection: $selectedMedia) {
                ForEach(importedAssets.indices, id: \.self) { index in
                    PageContentView(asset: importedAssets[index], currentMedia: $selectedMedia)
                        .onAppear {
                            print("Asset index #\(index) loaded")
                        }
                        .tag(importedAssets[index].id.uuidString)
                }
            }
            .tabViewStyle(
                PageTabViewStyle(indexDisplayMode: .never))
            .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Button(action: {
                        isPresented.toggle()
                    }) {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.black)
                    }
                    .padding(.leading)
                    Spacer()
                }
                Spacer()
            }
            VStack {
                Spacer()
                Image("ViewerTools", bundle: .main)
                    .resizable()
                    .scaledToFit()
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    let previewer = try? Previewer()
    return ViewerView(isPresented: .constant(true),
                      selectedMedia: previewer!.firstUUID)
        .modelContainer(previewer!.container)
}
