//
//  ContentView.swift
//  avpicker
//
//  Created by Will Hannah on 10/22/24.
//

import Factory
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Injected(\.appState) var appState: AppStateProtocol

    init() {
        UITabBar.appearance().barTintColor = UIColor(Color(.white))
        UITabBar.appearance().shadowImage = nil
    }

    var body: some View {
        TabView {
            Group {
                ImporterView()
                    .tabItem {
                        Image(systemName: "face.smiling")
                            .font(.title)
                    }
                    .environmentObject(ImporterViewModel())

                Text("Second View")
                    .tabItem {
                        Image(systemName: "play.rectangle")
                    }

                Text("Third View")
                    .tabItem {
                        Image(systemName: "circle.hexagonpath")
                    }

                Text("Fourth View")
                    .tabItem {
                        Image(systemName: "i.square")
                    }
                    .badge(1)
                    .badgeProminence(.increased)

                Text("Fifth View")
                    .tabItem {
                        Image(systemName: "hexagon")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .aspectRatio(contentMode: .fit)
                    }
            }
            .toolbarBackground(.white, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.light, for: .tabBar)
            .tint(.gray)
        }
    }
}

#Preview {
    ContentView()
}
