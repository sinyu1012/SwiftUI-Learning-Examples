//
//  ListNavigationView.swift
//  FirstIOSAppTest
//
//  SwiftUI 列表与导航示例
//

import SwiftUI

// 数据模型
struct TodoItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
    var category: Category
    
    enum Category: String, CaseIterable {
        case work = "工作"
        case personal = "个人"
        case shopping = "购物"
        
        var color: Color {
            switch self {
            case .work: return .blue
            case .personal: return .green
            case .shopping: return .orange
            }
        }
        
        var icon: String {
            switch self {
            case .work: return "briefcase.fill"
            case .personal: return "person.fill"
            case .shopping: return "cart.fill"
            }
        }
    }
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let age: Int
    let avatar: String
    let bio: String
}

struct ListNavigationView: View {
    @State private var todos = [
        TodoItem(title: "完成项目报告", isCompleted: false, category: .work),
        TodoItem(title: "买菜", isCompleted: true, category: .shopping),
        TodoItem(title: "健身", isCompleted: false, category: .personal),
        TodoItem(title: "开会讨论", isCompleted: false, category: .work),
        TodoItem(title: "购买生日礼物", isCompleted: false, category: .shopping)
    ]
    
    let people = [
        Person(name: "张三", age: 28, avatar: "person.circle", bio: "软件工程师，喜欢编程和阅读"),
        Person(name: "李四", age: 32, avatar: "person.circle.fill", bio: "设计师，热爱创意和艺术"),
        Person(name: "王五", age: 25, avatar: "person.crop.circle", bio: "产品经理，关注用户体验"),
        Person(name: "赵六", age: 30, avatar: "person.crop.circle.fill", bio: "数据分析师，擅长数据挖掘")
    ]
    
    @State private var selectedTab = 0
    @State private var searchText = ""
    
    var filteredTodos: [TodoItem] {
        if searchText.isEmpty {
            return todos
        } else {
            return todos.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1: 基本列表
            BasicListView(todos: $todos, filteredTodos: filteredTodos, searchText: $searchText)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("待办事项")
                }
                .tag(0)
            
            // Tab 2: 分组列表
            GroupedListView(people: people)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("联系人")
                }
                .tag(1)
            
            // Tab 3: 网格视图
            GridView()
                .tabItem {
                    Image(systemName: "grid")
                    Text("网格")
                }
                .tag(2)
        }
        .navigationTitle("列表与导航")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// 基本列表视图
struct BasicListView: View {
    @Binding var todos: [TodoItem]
    let filteredTodos: [TodoItem]
    @Binding var searchText: String
    
    var body: some View {
        VStack {
            List {
                Section("搜索和过滤") {
                    SearchBar(text: $searchText)
                }
                
                Section("待办事项") {
                    ForEach(filteredTodos) { todo in
                        NavigationLink(destination: TodoDetailView(todo: todo)) {
                            TodoRowView(todo: todo) {
                                toggleTodo(todo)
                            }
                        }
                    }
                    .onDelete(perform: deleteTodos)
                    .onMove(perform: moveTodos)
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            // 添加新待办事项
            AddTodoView { newTodo in
                todos.append(newTodo)
            }
        }
    }
    
    private func toggleTodo(_ todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
        }
    }
    
    private func deleteTodos(offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
    
    private func moveTodos(from source: IndexSet, to destination: Int) {
        todos.move(fromOffsets: source, toOffset: destination)
    }
}

// 分组列表视图
struct GroupedListView: View {
    let people: [Person]
    
    var groupedPeople: [String: [Person]] {
        Dictionary(grouping: people) { person in
            String(person.name.prefix(1))
        }
    }
    
    var body: some View {
        List {
            ForEach(groupedPeople.keys.sorted(), id: \.self) { key in
                Section(header: Text(key).font(.headline)) {
                    ForEach(groupedPeople[key]!, id: \.id) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            PersonRowView(person: person)
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

// 网格视图
struct GridView: View {
    let colors: [Color] = [.red, .blue, .green, .orange, .purple, .pink, .yellow, .mint]
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(0..<20, id: \.self) { index in
                    NavigationLink(destination: ColorDetailView(color: colors[index % colors.count], index: index)) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colors[index % colors.count])
                            .frame(height: 100)
                            .overlay(
                                Text("Item \(index + 1)")
                                    .foregroundColor(.white)
                                    .font(.headline)
                            )
                    }
                }
            }
            .padding()
        }
    }
}

// 辅助视图组件
struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("搜索待办事项...", text: $text)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

struct TodoRowView: View {
    let todo: TodoItem
    let onToggle: () -> Void
    
    var body: some View {
        HStack {
            Button(action: onToggle) {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todo.isCompleted ? .green : .gray)
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(todo.title)
                    .strikethrough(todo.isCompleted)
                    .foregroundColor(todo.isCompleted ? .gray : .primary)
                
                Label(todo.category.rawValue, systemImage: todo.category.icon)
                    .font(.caption)
                    .foregroundColor(todo.category.color)
            }
            
            Spacer()
        }
        .padding(.vertical, 2)
    }
}

struct PersonRowView: View {
    let person: Person
    
    var body: some View {
        HStack {
            Image(systemName: person.avatar)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(person.name)
                    .font(.headline)
                Text("年龄: \(person.age)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 2)
    }
}

struct AddTodoView: View {
    @State private var newTodoTitle = ""
    @State private var selectedCategory = TodoItem.Category.personal
    let onAdd: (TodoItem) -> Void
    
    var body: some View {
        VStack {
            HStack {
                TextField("添加新待办事项", text: $newTodoTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Picker("类别", selection: $selectedCategory) {
                    ForEach(TodoItem.Category.allCases, id: \.self) { category in
                        Label(category.rawValue, systemImage: category.icon)
                            .tag(category)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Button("添加") {
                    if !newTodoTitle.isEmpty {
                        let newTodo = TodoItem(title: newTodoTitle, isCompleted: false, category: selectedCategory)
                        onAdd(newTodo)
                        newTodoTitle = ""
                    }
                }
                .disabled(newTodoTitle.isEmpty)
            }
            .padding()
        }
    }
}

// 详情页面
struct TodoDetailView: View {
    let todo: TodoItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(todo.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Label(todo.category.rawValue, systemImage: todo.category.icon)
                .font(.title2)
                .foregroundColor(todo.category.color)
            
            Text("状态: \(todo.isCompleted ? "已完成" : "未完成")")
                .font(.title3)
                .foregroundColor(todo.isCompleted ? .green : .orange)
            
            Spacer()
        }
        .padding()
        .navigationTitle("待办详情")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PersonDetailView: View {
    let person: Person
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: person.avatar)
                .font(.system(size: 80))
                .foregroundColor(.blue)
            
            Text(person.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("年龄: \(person.age)")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text(person.bio)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ColorDetailView: View {
    let color: Color
    let index: Int
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(color)
                .frame(height: 200)
                .cornerRadius(20)
            
            Text("颜色 #\(index + 1)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("这是一个美丽的颜色示例")
                .font(.body)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle("颜色详情")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        ListNavigationView()
    }
} 