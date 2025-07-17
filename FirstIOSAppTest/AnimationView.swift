//
//  AnimationView.swift
//  FirstIOSAppTest
//
//  SwiftUI 动画效果示例
//

import SwiftUI

struct AnimationView: View {
    @State private var isAnimated = false
    @State private var rotationAngle = 0.0
    @State private var scaleAmount = 1.0
    @State private var offsetX = 0.0
    @State private var showCircle = false
    @State private var colorIndex = 0
    @State private var progress = 0.0
    
    let colors: [Color] = [.blue, .red, .green, .orange, .purple]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // 基本动画
                VStack(alignment: .leading, spacing: 15) {
                    Text("基本动画")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack {
                        VStack {
                            Text("旋转动画")
                                .font(.headline)
                            
                            Image(systemName: "star.fill")
                                .font(.title)
                                .foregroundColor(.yellow)
                                .rotationEffect(.degrees(rotationAngle))
                                .animation(.easeInOut(duration: 1), value: rotationAngle)
                            
                            Button("旋转") {
                                rotationAngle += 180
                            }
                            .buttonStyle(.bordered)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text("缩放动画")
                                .font(.headline)
                            
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 50, height: 50)
                                .scaleEffect(scaleAmount)
                                .animation(.spring(response: 0.5, dampingFraction: 0.5), value: scaleAmount)
                            
                            Button("缩放") {
                                scaleAmount = scaleAmount == 1.0 ? 1.5 : 1.0
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 移动动画
                VStack(alignment: .leading, spacing: 15) {
                    Text("移动动画")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 100)
                            .border(Color.gray, width: 1)
                        
                        Circle()
                            .fill(Color.red)
                            .frame(width: 30, height: 30)
                            .offset(x: offsetX)
                            .animation(.easeInOut(duration: 1), value: offsetX)
                    }
                    
                    HStack {
                        Button("向左") {
                            offsetX = -100
                        }
                        .buttonStyle(.bordered)
                        
                        Button("居中") {
                            offsetX = 0
                        }
                        .buttonStyle(.bordered)
                        
                        Button("向右") {
                            offsetX = 100
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 过渡动画
                VStack(alignment: .leading, spacing: 15) {
                    Text("过渡动画")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack {
                        if showCircle {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 80, height: 80)
                                .transition(.asymmetric(
                                    insertion: .scale.combined(with: .opacity),
                                    removal: .move(edge: .trailing).combined(with: .opacity)
                                ))
                        }
                    }
                    .frame(height: 100)
                    .animation(.easeInOut(duration: 0.8), value: showCircle)
                    
                    Button(showCircle ? "隐藏圆形" : "显示圆形") {
                        showCircle.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 颜色动画
                VStack(alignment: .leading, spacing: 15) {
                    Text("颜色动画")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(colors[colorIndex])
                        .frame(height: 80)
                        .animation(.easeInOut(duration: 0.5), value: colorIndex)
                    
                    Button("改变颜色") {
                        colorIndex = (colorIndex + 1) % colors.count
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 进度动画
                VStack(alignment: .leading, spacing: 15) {
                    Text("进度动画")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 10) {
                        // 线性进度条
                        ProgressView(value: progress)
                            .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                            .animation(.easeInOut(duration: 2), value: progress)
                        
                        // 圆形进度条
                        ZStack {
                            Circle()
                                .stroke(Color.gray.opacity(0.3), lineWidth: 8)
                            
                            Circle()
                                .trim(from: 0, to: progress)
                                .stroke(Color.blue, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                                .rotationEffect(.degrees(-90))
                                .animation(.easeInOut(duration: 2), value: progress)
                            
                            Text("\(Int(progress * 100))%")
                                .font(.headline)
                        }
                        .frame(width: 80, height: 80)
                    }
                    
                    HStack {
                        Button("开始") {
                            progress = 1.0
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("重置") {
                            progress = 0.0
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 复杂动画组合
                VStack(alignment: .leading, spacing: 15) {
                    Text("复杂动画组合")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ComplexAnimationExample()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 弹簧动画
                VStack(alignment: .leading, spacing: 15) {
                    Text("弹簧动画")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    SpringAnimationExample()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("动画效果")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 复杂动画示例
struct ComplexAnimationExample: View {
    @State private var isExpanded = false
    @State private var cardOffset = CGSize.zero
    @State private var cardRotation = 0.0
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(LinearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: isExpanded ? 250 : 150, height: isExpanded ? 150 : 100)
                .offset(cardOffset)
                .rotationEffect(.degrees(cardRotation))
                .overlay(
                    VStack {
                        Image(systemName: "star.fill")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("魔法卡片")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    .scaleEffect(isExpanded ? 1.2 : 1.0)
                )
                .animation(.spring(response: 0.6, dampingFraction: 0.8), value: isExpanded)
                .animation(.easeInOut(duration: 0.5), value: cardOffset)
                .animation(.easeInOut(duration: 0.5), value: cardRotation)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            cardOffset = gesture.translation
                            cardRotation = Double(gesture.translation.width / 10)
                        }
                        .onEnded { _ in
                            withAnimation(.spring()) {
                                cardOffset = .zero
                                cardRotation = 0
                            }
                        }
                )
            
            Button(isExpanded ? "收缩" : "展开") {
                isExpanded.toggle()
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
            
            Text("可以拖拽上面的卡片")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

// 弹簧动画示例
struct SpringAnimationExample: View {
    @State private var bounceOffset = 0.0
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ZStack {
                // 地面
                Rectangle()
                    .fill(Color.brown.opacity(0.3))
                    .frame(height: 20)
                    .offset(y: 60)
                
                // 弹跳球
                Circle()
                    .fill(RadialGradient(colors: [.orange, .red], center: .topLeading, startRadius: 5, endRadius: 25))
                    .frame(width: 40, height: 40)
                    .offset(y: bounceOffset)
                    .animation(.interpolatingSpring(stiffness: 300, damping: 5), value: bounceOffset)
            }
            .frame(height: 120)
            
            Button(isAnimating ? "停止弹跳" : "开始弹跳") {
                if isAnimating {
                    bounceOffset = 0
                    isAnimating = false
                } else {
                    startBouncing()
                    isAnimating = true
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    private func startBouncing() {
        bounceOffset = 50
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            if isAnimating {
                bounceOffset = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    if isAnimating {
                        startBouncing()
                    }
                }
            }
        }
    }
}

// 呼吸效果动画
struct BreathingAnimationView: View {
    @State private var scale = 1.0
    
    var body: some View {
        Circle()
            .fill(RadialGradient(colors: [.blue, .cyan], center: .center, startRadius: 10, endRadius: 50))
            .frame(width: 100, height: 100)
            .scaleEffect(scale)
            .animation(
                .easeInOut(duration: 2)
                .repeatForever(autoreverses: true),
                value: scale
            )
            .onAppear {
                scale = 1.3
            }
    }
}

// 粒子效果动画
struct ParticleEffectView: View {
    @State private var particles: [Particle] = []
    
    struct Particle: Identifiable {
        let id = UUID()
        var x: Double
        var y: Double
        var opacity: Double = 1.0
        var scale: Double = 1.0
    }
    
    var body: some View {
        ZStack {
            ForEach(particles) { particle in
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 8, height: 8)
                    .scaleEffect(particle.scale)
                    .opacity(particle.opacity)
                    .position(x: particle.x, y: particle.y)
            }
        }
        .frame(width: 200, height: 200)
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
        .onTapGesture {
            createParticles(at: CGPoint(x: 100, y: 100))
        }
        .overlay(
            Text("点击创建粒子效果")
                .font(.caption)
                .foregroundColor(.secondary),
            alignment: .bottom
        )
    }
    
    private func createParticles(at point: CGPoint) {
        for _ in 0..<10 {
            let particle = Particle(
                x: point.x + Double.random(in: -50...50),
                y: point.y + Double.random(in: -50...50)
            )
            particles.append(particle)
            
            // 动画移除粒子
            withAnimation(.easeOut(duration: 2)) {
                if let index = particles.firstIndex(where: { $0.id == particle.id }) {
                    particles[index].opacity = 0
                    particles[index].scale = 0
                }
            }
            
            // 2秒后移除粒子
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                particles.removeAll { $0.id == particle.id }
            }
        }
    }
}

#Preview {
    NavigationView {
        AnimationView()
    }
} 