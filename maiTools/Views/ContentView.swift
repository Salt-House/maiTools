//
//  ContentView.swift
//  maiTools
//
//  Created by 马硕 on 2025/4/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            TabView {
                HomePageView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("主页")
                    }
                MusicPageView()
                    .tabItem {
                        Image(systemName: "music.note.list")
                        Text("音乐")
                    }
                ToolsView()
                    .tabItem {
                        Image(systemName: "wrench.and.screwdriver")
                        Text("工具")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("我的")
                    }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
}
