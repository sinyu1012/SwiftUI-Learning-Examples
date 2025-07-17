//
//  CustomComponentsView.swift
//  FirstIOSAppTest
//
//  SwiftUI 自定义组件示例
//

import SwiftUI

struct CustomComponentsView: View {
    @State private var currentRating = 4
    @State private var badgeCount = 5
    @State private var selectedTab = 0
    @State private var isPressed = false
    @State private var cardData = [
        CardData(title: "卡片1", description: "这是第一张卡片", color: .blue),
        CardData(title: "卡片2", description: "这是第二张卡片", color: .green),
        CardData(title: "卡片3", description: "这是第三张卡片", color: .orange)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // 自定义按钮组件
                VStack(alignment: .leading, spacing: 15) {
                    Text("自定义按钮组件")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 10) {
                        CustomButton(title: "主要按钮", style: .primary) {
                            print("主要按钮被点击")
                        }
                        
                        CustomButton(title: "次要按钮", style: .secondary) {
                            print("次要按钮被点击")
                        }
                        
                        CustomButton(title: "危险按钮", style: .destructive) {
                            print("危险按钮被点击")
                        }
                        
                        IconButton(icon: "heart.fill", title: "收藏", color: .red) {
                            print("收藏按钮被点击")
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 评分组件
                VStack(alignment: .leading, spacing: 15) {
                    Text("评分组件")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 15) {
                        HStack {
                            Text("当前评分: \(currentRating)")
                            Spacer()
                        }
                        
                        StarRatingComponent(rating: $currentRating, maxRating: 5)
                        
                        RatingDisplayComponent(rating: currentRating, totalReviews: 128)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 徽章和标签组件
                VStack(alignment: .leading, spacing: 15) {
                    Text("徽章和标签组件")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 15) {
                        HStack {
                            BadgeView(count: badgeCount, color: .red)
                            Text("通知")
                            Spacer()
                            Stepper("", value: $badgeCount, in: 0...99)
                                .labelsHidden()
                        }
                        
                        HStack {
                            TagView(text: "新", style: .primary)
                            TagView(text: "热门", style: .warning)
                            TagView(text: "推荐", style: .success)
                            Spacer()
                        }
                        
                        StatusIndicator(status: .online, text: "在线")
                        StatusIndicator(status: .away, text: "离开")
                        StatusIndicator(status: .offline, text: "离线")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 卡片组件
                VStack(alignment: .leading, spacing: 15) {
                    Text("卡片组件")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 12) {
                        ForEach(cardData.indices, id: \.self) { index in
                            CustomCard(data: cardData[index]) {
                                // 卡片点击事件
                                print("卡片 \(cardData[index].title) 被点击")
                            }
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 进度组件
                VStack(alignment: .leading, spacing: 15) {
                    Text("进度组件")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 15) {
                        ProgressBarComponent(progress: 0.7, color: .blue, title: "下载进度")
                        ProgressBarComponent(progress: 0.4, color: .green, title: "上传进度")
                        
                        CircularProgressComponent(progress: 0.8, color: .orange, size: 80)
                        
                        StepProgressComponent(currentStep: 2, totalSteps: 4)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 输入组件
                VStack(alignment: .leading, spacing: 15) {
                    Text("输入组件")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 15) {
                        FloatingLabelTextField(placeholder: "用户名", text: .constant(""))
                        FloatingLabelTextField(placeholder: "密码", text: .constant(""), isSecure: true)
                        
                        SearchBarComponent(searchText: .constant(""), placeholder: "搜索内容...")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 导航组件
                VStack(alignment: .leading, spacing: 15) {
                    Text("导航组件")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    CustomTabView(selectedTab: $selectedTab)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("自定义组件")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - 自定义按钮组件

enum ButtonStyle {
    case primary, secondary, destructive
    
    var backgroundColor: Color {
        switch self {
        case .primary: return .blue
        case .secondary: return .gray
        case .destructive: return .red
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .primary, .destructive: return .white
        case .secondary: return .primary
        }
    }
}

struct CustomButton: View {
    let title: String
    let style: ButtonStyle
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding()
                .background(style.backgroundColor)
                .foregroundColor(style.foregroundColor)
                .cornerRadius(10)
        }
    }
}

struct IconButton: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                Text(title)
            }
            .foregroundColor(color)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(color, lineWidth: 1)
            )
        }
    }
}

// 移除自定义 ButtonStyle 以避免编译错误

// MARK: - 评分组件

struct StarRatingComponent: View {
    @Binding var rating: Int
    let maxRating: Int
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundColor(star <= rating ? .yellow : .gray)
                    .font(.title2)
                    .onTapGesture {
                        rating = star
                    }
            }
        }
    }
}

struct RatingDisplayComponent: View {
    let rating: Int
    let totalReviews: Int
    
    var body: some View {
        HStack {
            HStack(spacing: 2) {
                ForEach(1...5, id: \.self) { star in
                    Image(systemName: star <= rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.caption)
                }
            }
            
            Text("\(rating).0")
                .font(.caption)
                .fontWeight(.semibold)
            
            Text("(\(totalReviews) 评价)")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Spacer()
        }
    }
}

// MARK: - 徽章和标签组件

struct BadgeView: View {
    let count: Int
    let color: Color
    
    var body: some View {
        ZStack {
            if count > 0 {
                Circle()
                    .fill(color)
                    .frame(width: count > 99 ? 24 : 20, height: count > 99 ? 24 : 20)
                
                Text(count > 99 ? "99+" : "\(count)")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
        }
    }
}

enum TagStyle {
    case primary, warning, success
    
    var backgroundColor: Color {
        switch self {
        case .primary: return .blue.opacity(0.1)
        case .warning: return .orange.opacity(0.1)
        case .success: return .green.opacity(0.1)
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .primary: return .blue
        case .warning: return .orange
        case .success: return .green
        }
    }
}

struct TagView: View {
    let text: String
    let style: TagStyle
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(style.backgroundColor)
            .foregroundColor(style.foregroundColor)
            .cornerRadius(12)
    }
}

enum Status {
    case online, away, offline
    
    var color: Color {
        switch self {
        case .online: return .green
        case .away: return .orange
        case .offline: return .gray
        }
    }
}

struct StatusIndicator: View {
    let status: Status
    let text: String
    
    var body: some View {
        HStack {
            Circle()
                .fill(status.color)
                .frame(width: 8, height: 8)
            Text(text)
                .font(.caption)
        }
    }
}

// MARK: - 卡片组件

struct CardData {
    let title: String
    let description: String
    let color: Color
}

struct CustomCard: View {
    let data: CardData
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Rectangle()
                    .fill(data.color)
                    .frame(width: 4)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(data.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(data.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - 进度组件

struct ProgressBarComponent: View {
    let progress: Double
    let color: Color
    let title: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.caption)
                Spacer()
                Text("\(Int(progress * 100))%")
                    .font(.caption)
                    .fontWeight(.medium)
            }
            
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: color))
        }
    }
}

struct CircularProgressComponent: View {
    let progress: Double
    let color: Color
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.3), lineWidth: 8)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
            
            Text("\(Int(progress * 100))%")
                .font(.headline)
                .fontWeight(.bold)
        }
        .frame(width: size, height: size)
    }
}

struct StepProgressComponent: View {
    let currentStep: Int
    let totalSteps: Int
    
    var body: some View {
        HStack {
            ForEach(1...totalSteps, id: \.self) { step in
                Circle()
                    .fill(step <= currentStep ? Color.blue : Color.gray.opacity(0.3))
                    .frame(width: 20, height: 20)
                    .overlay(
                        Text("\(step)")
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(step <= currentStep ? .white : .gray)
                    )
                
                if step < totalSteps {
                    Rectangle()
                        .fill(step < currentStep ? Color.blue : Color.gray.opacity(0.3))
                        .frame(height: 2)
                }
            }
        }
    }
}

// MARK: - 输入组件

struct FloatingLabelTextField: View {
    let placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    @State private var isEditing = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text(placeholder)
                .foregroundColor(.secondary)
                .offset(y: (isEditing || !text.isEmpty) ? -25 : 0)
                .scaleEffect((isEditing || !text.isEmpty) ? 0.8 : 1.0, anchor: .leading)
                .animation(.easeInOut(duration: 0.2), value: isEditing || !text.isEmpty)
            
            if isSecure {
                SecureField("", text: $text)
                    .onTapGesture {
                        isEditing = true
                    }
            } else {
                TextField("", text: $text)
                    .onTapGesture {
                        isEditing = true
                    }
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke((isEditing || !text.isEmpty) ? Color.blue : Color.gray.opacity(0.5), lineWidth: 1)
        )
        .onTapGesture {
            isEditing = true
        }
    }
}

struct SearchBarComponent: View {
    @Binding var searchText: String
    let placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            
            TextField(placeholder, text: $searchText)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

// MARK: - 导航组件

struct CustomTabView: View {
    @Binding var selectedTab: Int
    
    let tabs = [
        ("home", "首页"),
        ("star", "收藏"),
        ("person", "我的")
    ]
    
    var body: some View {
        HStack {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tabs[index].0 + (selectedTab == index ? ".fill" : ""))
                            .font(.title2)
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                        
                        Text(tabs[index].1)
                            .font(.caption)
                            .foregroundColor(selectedTab == index ? .blue : .gray)
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

#Preview {
    NavigationView {
        CustomComponentsView()
    }
} 