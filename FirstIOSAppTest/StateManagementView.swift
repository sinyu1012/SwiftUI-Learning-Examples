//
//  StateManagementView.swift
//  FirstIOSAppTest
//
//  SwiftUI 状态管理示例
//

import SwiftUI

// ObservableObject示例 - 类似Flutter的ChangeNotifier
class CounterViewModel: ObservableObject {
    @Published var count = 0
    @Published var name = "计数器"
    
    func increment() {
        count += 1
    }
    
    func decrement() {
        count -= 1
    }
    
    func reset() {
        count = 0
    }
}

// 用户模型
struct User {
    var name: String
    var age: Int
    var email: String
}

struct StateManagementView: View {
    // @State - 本地状态管理（类似Flutter的setState）
    @State private var simpleCounter = 0
    @State private var text = ""
    @State private var isVisible = true
    @State private var selectedColor = Color.blue
    
    // @StateObject - 创建并管理ObservableObject的生命周期
    @StateObject private var viewModel = CounterViewModel()
    
    // 用户信息状态
    @State private var user = User(name: "张三", age: 25, email: "zhang@example.com")
    
    let colors: [Color] = [.blue, .red, .green, .orange, .purple]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // @State 示例
                VStack(alignment: .leading, spacing: 10) {
                    Text("@State 本地状态管理")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("简单计数器:")
                    HStack {
                        Button("-") {
                            simpleCounter -= 1
                        }
                        .buttonStyle(.bordered)
                        
                        Text("\(simpleCounter)")
                            .frame(minWidth: 50)
                            .font(.title2)
                        
                        Button("+") {
                            simpleCounter += 1
                        }
                        .buttonStyle(.bordered)
                    }
                    
                    // 文本输入状态
                    VStack(alignment: .leading) {
                        Text("文本输入:")
                        TextField("输入一些文字", text: $text)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        if !text.isEmpty {
                            Text("你输入了: \(text)")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // 可见性切换
                    VStack(alignment: .leading) {
                        Toggle("显示内容", isOn: $isVisible)
                        if isVisible {
                            Text("这个内容是可见的！")
                                .padding()
                                .background(Color.green.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                
                // @StateObject/@ObservedObject 示例
                VStack(alignment: .leading, spacing: 10) {
                    Text("@StateObject/@ObservedObject 示例")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("ViewModel计数器: \(viewModel.name)")
                    
                    HStack {
                        Button("减少") {
                            viewModel.decrement()
                        }
                        .buttonStyle(.bordered)
                        
                        Text("\(viewModel.count)")
                            .frame(minWidth: 50)
                            .font(.title)
                            .foregroundColor(viewModel.count > 0 ? .green : .red)
                        
                        Button("增加") {
                            viewModel.increment()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    Button("重置") {
                        viewModel.reset()
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.orange)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
                
                // 结构体状态管理
                VStack(alignment: .leading, spacing: 10) {
                    Text("结构体状态管理")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("姓名:")
                            TextField("姓名", text: $user.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        HStack {
                            Text("年龄:")
                            TextField("年龄", value: $user.age, format: .number)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                        }
                        
                        HStack {
                            Text("邮箱:")
                            TextField("邮箱", text: $user.email)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.emailAddress)
                        }
                    }
                    
                    // 显示用户信息
                    VStack(alignment: .leading, spacing: 4) {
                        Text("用户信息:")
                            .font(.headline)
                        Text("姓名: \(user.name)")
                        Text("年龄: \(user.age)")
                        Text("邮箱: \(user.email)")
                    }
                    .padding()
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding()
                .background(Color.purple.opacity(0.1))
                .cornerRadius(10)
                
                // 颜色选择器
                VStack(alignment: .leading, spacing: 10) {
                    Text("颜色状态管理")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("选择一个颜色:")
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 10) {
                        ForEach(colors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Circle()
                                        .stroke(selectedColor == color ? Color.black : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    selectedColor = color
                                }
                        }
                    }
                    
                    Rectangle()
                        .fill(selectedColor)
                        .frame(height: 60)
                        .cornerRadius(8)
                        .overlay(
                            Text("选中的颜色")
                                .foregroundColor(.white)
                                .font(.headline)
                        )
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("状态管理")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        StateManagementView()
    }
} 