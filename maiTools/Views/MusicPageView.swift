//
//  MusicPageView.swift
//  maiTools
//
//  Created by 马硕 on 2025/4/17.
//

import SwiftUI

struct MusicPageView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    Text("Music")
                }
                .padding()
            }
            .navigationTitle("音乐")
            .searchable(text: .constant(""), prompt: "乐曲名/别名/作曲家")
        }
    }
}

#Preview {
    MusicPageView()
}
