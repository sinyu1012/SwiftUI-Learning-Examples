//
//  LayoutExamplesView.swift
//  FirstIOSAppTest
//
//  SwiftUI 布局示例
//

import SwiftUI

struct LayoutExamplesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // VStack 示例
                VStack(alignment: .leading, spacing: 10) {
                    Text("VStack (垂直布局)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 8) {
                        Text("项目 1")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                        
                        Text("项目 2")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(8)
                        
                        Text("项目 3")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // HStack 示例
                VStack(alignment: .leading, spacing: 10) {
                    Text("HStack (水平布局)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 8) {
                        Text("左")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.2))
                            .cornerRadius(8)
                        
                        Text("中")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.yellow.opacity(0.2))
                            .cornerRadius(8)
                        
                        Text("右")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.purple.opacity(0.2))
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // ZStack 示例
                VStack(alignment: .leading, spacing: 10) {
                    Text("ZStack (层叠布局)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.blue.opacity(0.3))
                            .frame(width: 200, height: 200)
                            .cornerRadius(20)
                        
                        Circle()
                            .fill(Color.red.opacity(0.5))
                            .frame(width: 120, height: 120)
                        
                        Text("重叠文本")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // Grid 布局示例
                VStack(alignment: .leading, spacing: 10) {
                    Text("LazyVGrid (网格布局)")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(1...9, id: \.self) { number in
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.mint.opacity(0.7))
                                .frame(height: 60)
                                .overlay(
                                    Text("\(number)")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                )
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 复杂布局示例
                VStack(alignment: .leading, spacing: 10) {
                    Text("复杂布局组合")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    CardLayoutExample()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 对齐和间距示例
                VStack(alignment: .leading, spacing: 10) {
                    Text("对齐和间距")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    AlignmentExamples()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // 响应式布局示例
                VStack(alignment: .leading, spacing: 10) {
                    Text("响应式布局")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ResponsiveLayoutExample()
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("布局示例")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 卡片布局示例
struct CardLayoutExample: View {
    var body: some View {
        VStack(spacing: 15) {
            ForEach(0..<3) { index in
                HStack {
                    // 头像
                    Circle()
                        .fill(Color.blue.opacity(0.7))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Text("\(index + 1)")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        )
                    
                    // 内容
                    VStack(alignment: .leading, spacing: 4) {
                        Text("用户 \(index + 1)")
                            .font(.headline)
                        Text("这是一个示例描述文本，展示了SwiftUI的布局能力。")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    // 操作按钮
                    VStack(spacing: 8) {
                        Button(action: {}) {
                            Image(systemName: "heart")
                                .foregroundColor(.red)
                        }
                        Button(action: {}) {
                            Image(systemName: "message")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)
            }
        }
    }
}

// 对齐示例
struct AlignmentExamples: View {
    var body: some View {
        VStack(spacing: 15) {
            // 左对齐
            VStack(alignment: .leading, spacing: 5) {
                Text("左对齐 (.leading)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("短文本")
                Text("这是一个比较长的文本内容")
                Text("中等长度文本")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(8)
            
            // 居中对齐
            VStack(alignment: .center, spacing: 5) {
                Text("居中对齐 (.center)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("短文本")
                Text("这是一个比较长的文本内容")
                Text("中等长度文本")
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
            
            // 右对齐
            VStack(alignment: .trailing, spacing: 5) {
                Text("右对齐 (.trailing)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("短文本")
                Text("这是一个比较长的文本内容")
                Text("中等长度文本")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding()
            .background(Color.orange.opacity(0.1))
            .cornerRadius(8)
        }
    }
}

// 响应式布局示例
struct ResponsiveLayoutExample: View {
    @State private var isCompact = false
    
    var body: some View {
        VStack(spacing: 15) {
            Toggle("紧凑模式", isOn: $isCompact)
            
            if isCompact {
                // 紧凑布局
                VStack(spacing: 10) {
                    ForEach(1...4, id: \.self) { number in
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("项目 \(number)")
                            Spacer()
                            Text("详情")
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
            } else {
                // 宽松布局
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]
                
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(1...4, id: \.self) { number in
                        VStack {
                            Image(systemName: "star.fill")
                                .font(.title)
                                .foregroundColor(.yellow)
                            Text("项目 \(number)")
                                .font(.headline)
                            Text("详细描述")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(height: 80)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                    }
                }
            }
        }
    }
}

// Spacer 和 Frame 示例
struct SpacerFrameExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Spacer 示例")
                .font(.headline)
            
            HStack {
                Text("左侧")
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(8)
                
                Spacer() // 占用所有可用空间
                
                Text("右侧")
                    .padding()
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(8)
            }
            
            Text("Frame 示例")
                .font(.headline)
            
            VStack(spacing: 10) {
                Text("固定大小")
                    .frame(width: 200, height: 50)
                    .background(Color.red.opacity(0.2))
                    .cornerRadius(8)
                
                Text("最小/最大大小")
                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 30)
                    .background(Color.purple.opacity(0.2))
                    .cornerRadius(8)
                
                Text("填充可用空间")
                    .frame(maxWidth: .infinity, maxHeight: 60)
                    .background(Color.orange.opacity(0.2))
                    .cornerRadius(8)
            }
        }
    }
}

#Preview {
    NavigationView {
        LayoutExamplesView()
    }
} 