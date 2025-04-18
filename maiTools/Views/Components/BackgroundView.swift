//
//  BackgroundView.swift
//  maiTools
//
//  Created by 马硕 on 2025/4/17.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color(red: 133 / 255, green: 144 / 255, blue: 250 / 255), location: 0),
                    .init(color: Color(red: 201 / 255, green: 248 / 255, blue: 229 / 255), location: 0.7),
                    .init(color: Color(red: 239 / 255, green: 246 / 255, blue: 255 / 255), location: 0.85),
                    .init(color: Color.white, location: 0.9),
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            StarMoveView()
        }
    }
    
}

struct StarMoveView: View {
    let count: Int
    @State private var stars: [StarModel] = []
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    init(count: Int = 4) {
        self.count = count
    }
    
    var body: some View {
        ZStack {
            ForEach(stars) { star in
                SingleStarView(star: star)
            }
        }
        .onAppear {
            generateNewStars()
        }
        .onDisappear {
            // 视图消失时清空所有星星
            stars.removeAll()
        }
        .onReceive(timer) { _ in
            // 定期生成新的星星
            generateNewStars()
        }
    }
    
    private func generateNewStars() {
        // 计算水平方向上的步长
        let step = 100.0 / CGFloat(count)
        
        let newStars = (0..<count).map { index in
            // 计算每个星星的水平位置，使其均匀分布
            // 整体向右偏移20%，使星星初始位置更靠右
            let baseX = CGFloat(index) * step + 20
            // 在基础位置上添加一些随机偏移，使分布不那么机械
            let randomOffset = CGFloat.random(in: 0..<(step * 0.5))
            // 确保位置不超过100%
            let xPosition = min(baseX + randomOffset, 100)
            
            return StarModel(
                id: UUID(),
                position: CGPoint(
                    x: xPosition,
                    y: 5
                )
            )
        }
        
        // 直接替换旧的星星，而不是追加
        if stars.count >= count {
            stars.removeAll()
        }
        stars.append(contentsOf: newStars)
        
        // 确保星星数量不超过count
        if stars.count > count {
            stars = Array(stars.suffix(count))
        }
    }
}

struct StarModel: Identifiable {
    let id: UUID
    let position: CGPoint
}

struct SingleStarView: View {
    let star: StarModel
    @State private var isAnimating = false
    @State private var opacity = 0.0
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        Image("star")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .position(
                x: UIScreen.main.bounds.width * star.position.x / 100,
                y: UIScreen.main.bounds.height * star.position.y / 100
            )
            .opacity(opacity)
            .offset(
                x: isAnimating ? -UIScreen.main.bounds.width : 0,
                y: isAnimating ? UIScreen.main.bounds.height * 0.5 : 0
            )
            .onAppear {
                withAnimation(.easeIn(duration: 0.8)) {
                    opacity = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(Animation.linear(duration: 3)) {
                        isAnimating = true
                        opacity = 0.0
                    }
                }
            }
            .onChange(of: scenePhase, initial: false) { newPhase,initial  in
                if newPhase != .active {
                    opacity = 0
                }
            }
            .zIndex(-2)
    }
}

struct StarMoveModifier: ViewModifier {
    @State private var isAnimating = false
    @State private var opacity = 0.0
    
    func body(content: Content) -> some View {
        content
            .opacity(opacity)  // 使用单独的opacity状态变量控制透明度
            .offset(
                x: isAnimating ? -UIScreen.main.bounds.width : 0,
                y: isAnimating ? UIScreen.main.bounds.height * 0.5 : 0
            )
            .onAppear {
                withAnimation(.easeIn(duration: 0.8)) {
                    opacity = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isAnimating = true
                    
                    withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
                        opacity = 0.0
                    }
                }
            }
            .animation(
                Animation.linear(duration: 3)
                    .repeatForever(autoreverses: false),
                value: isAnimating
            )
    }
}

#Preview {
    BackgroundView()
}
