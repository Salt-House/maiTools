//
//  ToolsView.swift
//  maiTools
//
//  Created by 马硕 on 2025/4/17.
//

import SwiftUI

struct ToolsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    Text("Tools")
                }
            }
            .navigationTitle("工具")
        }
    }
}

#Preview {
    ToolsView()
}
