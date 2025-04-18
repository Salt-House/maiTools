//
//  HomePageView.swift
//  maiTools
//
//  Created by 马硕 on 2025/4/16.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
                    Text("Home")
                }
            }
            .navigationTitle("maiTools")
        }
    }
    
}

#Preview {
    HomePageView()
}
