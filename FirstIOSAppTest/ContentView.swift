//
//  ContentView.swift
//  FirstIOSAppTest
//
//  Created by 沈新宇 on 2025/7/17.
//

import SwiftUI

struct ContentView: View {
    let examples = [
        ExampleItem(title: "基本UI组件", subtitle: "Text, Button, Image等", destination: BasicUIView()),
        ExampleItem(title: "状态管理", subtitle: "@State, @ObservedObject等", destination: StateManagementView()),
        ExampleItem(title: "列表与导航", subtitle: "List, NavigationView等", destination: ListNavigationView()),
        ExampleItem(title: "表单与输入", subtitle: "TextField, Form等", destination: FormInputView()),
        ExampleItem(title: "布局示例", subtitle: "VStack, HStack, Grid等", destination: LayoutExamplesView()),
        ExampleItem(title: "动画效果", subtitle: "Animation, Transition等", destination: AnimationView()),
        ExampleItem(title: "自定义组件", subtitle: "可复用的自定义View", destination: CustomComponentsView()),
        ExampleItem(title: "网络请求", subtitle: "API调用与数据展示", destination: NetworkingView())
    ]
    
    var body: some View {
        NavigationView {
            List(examples) { example in
                NavigationLink(destination: AnyView(example.destination)) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(example.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(example.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 2)
                }
            }
            .navigationTitle("SwiftUI 学习示例")
        }
    }
}

struct ExampleItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let destination: any View
}

#Preview {
    ContentView()
}
