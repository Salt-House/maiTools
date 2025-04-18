//
//  ProfileView.swift
//  maiTools
//
//  Created by 马硕 on 2025/4/17.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    Text("Profile")
                }
            }
            .navigationTitle("我的")
        }
    }
}

#Preview {
    ProfileView()
}
