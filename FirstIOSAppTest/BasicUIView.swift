//
//  BasicUIView.swift
//  FirstIOSAppTest
//
//  SwiftUI 基本UI组件示例
//

import SwiftUI

struct BasicUIView: View {
    @State private var counter = 0
    @State private var sliderValue = 50.0
    @State private var isToggleOn = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Group {
                    // 文本示例
                    VStack(alignment: .leading, spacing: 8) {
                        Text("文本组件 (Text)")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("普通文本")
                        Text("粗体文本").bold()
                        Text("斜体文本").italic()
                        Text("自定义颜色").foregroundColor(.blue)
                        Text("大字体").font(.title)
                        Text("小字体").font(.caption)
                    }
                    
                    Divider()
                    
                    // 按钮示例
                    VStack(alignment: .leading, spacing: 8) {
                        Text("按钮组件 (Button)")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 15) {
                            Button("默认按钮") {
                                counter += 1
                            }
                            
                            Button("样式按钮") {
                                counter += 1
                            }
                            .buttonStyle(.borderedProminent)
                            
                            Button("圆角按钮") {
                                counter += 1
                            }
                            .buttonStyle(.bordered)
                            .cornerRadius(20)
                        }
                        
                        Text("点击次数: \(counter)")
                            .padding(.top, 8)
                    }
                    
                    Divider()
                    
                    // 图片示例
                    VStack(alignment: .leading, spacing: 8) {
                        Text("图片组件 (Image)")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 20) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .imageScale(.large)
                            
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .font(.title)
                            
                            Image(systemName: "bolt.fill")
                                .foregroundColor(.orange)
                                .font(.title2)
                        }
                    }
                }
                
                Divider()
                
                Group {
                    // 滑块示例
                    VStack(alignment: .leading, spacing: 8) {
                        Text("滑块组件 (Slider)")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Slider(value: $sliderValue, in: 0...100)
                        Text("当前值: \(Int(sliderValue))")
                        
                        ProgressView(value: sliderValue / 100)
                            .progressViewStyle(LinearProgressViewStyle())
                    }
                    
                    Divider()
                    
                    // 开关示例
                    VStack(alignment: .leading, spacing: 8) {
                        Text("开关组件 (Toggle)")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Toggle("启用功能", isOn: $isToggleOn)
                        
                        if isToggleOn {
                            Text("功能已启用 ✅")
                                .foregroundColor(.green)
                        } else {
                            Text("功能已禁用 ❌")
                                .foregroundColor(.red)
                        }
                    }
                    
                    Divider()
                    
                    // 其他UI组件
                    VStack(alignment: .leading, spacing: 8) {
                        Text("其他组件")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        // 标签
                        HStack {
                            Text("标签:")
                            Label("标签示例", systemImage: "tag")
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.blue.opacity(0.1))
                                .cornerRadius(8)
                        }
                        
                        // 链接
                        Link("访问Apple官网", destination: URL(string: "https://www.apple.com")!)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("基本UI组件")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        BasicUIView()
    }
} 