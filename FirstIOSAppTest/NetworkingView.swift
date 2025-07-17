//
//  NetworkingView.swift
//  FirstIOSAppTest
//
//  SwiftUI 网络请求示例
//

import SwiftUI
import Foundation

// MARK: - 数据模型

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}

struct APIUser: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
    
    struct Address: Codable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
    }
    
    struct Company: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}

struct Photo: Codable, Identifiable {
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

// MARK: - 网络服务

class NetworkService: ObservableObject {
    @Published var posts: [Post] = []
    @Published var users: [APIUser] = []
    @Published var photos: [Photo] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    func fetchPosts() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "\(baseURL)/posts") else {
            errorMessage = "无效的URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "网络错误: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "没有收到数据"
                    return
                }
                
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    self?.posts = Array(posts.prefix(10))
                } catch {
                    self?.errorMessage = "数据解析失败: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    func fetchUsers() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "\(baseURL)/users") else {
            errorMessage = "无效的URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = "网络错误: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "没有收到数据"
                    return
                }
                
                do {
                    let users = try JSONDecoder().decode([APIUser].self, from: data)
                    self?.users = users
                } catch {
                    self?.errorMessage = "数据解析失败: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

// MARK: - 主视图

struct NetworkingView: View {
    @StateObject private var networkService = NetworkService()
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PostsListView()
                .environmentObject(networkService)
                .tabItem {
                    Image(systemName: "doc.text")
                    Text("文章")
                }
                .tag(0)
            
            UsersListView()
                .environmentObject(networkService)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("用户")
                }
                .tag(1)
        }
        .navigationTitle("网络请求示例")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Posts列表视图

struct PostsListView: View {
    @EnvironmentObject var networkService: NetworkService
    
    var body: some View {
        VStack {
            if networkService.isLoading {
                ProgressView("加载中...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let errorMessage = networkService.errorMessage {
                VStack(spacing: 10) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                    Text("加载失败")
                        .font(.headline)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    Button("重试") {
                        networkService.fetchPosts()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if networkService.posts.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "doc.text")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    Text("暂无文章")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Button("加载文章") {
                        networkService.fetchPosts()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(networkService.posts) { post in
                    PostRowView(post: post)
                }
                .refreshable {
                    networkService.fetchPosts()
                }
            }
        }
        .onAppear {
            if networkService.posts.isEmpty {
                networkService.fetchPosts()
            }
        }
    }
}

struct PostRowView: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(post.title)
                .font(.headline)
                .lineLimit(2)
            
            Text(post.body)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            HStack {
                Label("用户 \(post.userId)", systemImage: "person")
                    .font(.caption)
                    .foregroundColor(.blue)
                Spacer()
                Text("ID: \(post.id)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Users列表视图

struct UsersListView: View {
    @EnvironmentObject var networkService: NetworkService
    
    var body: some View {
        VStack {
            if networkService.isLoading {
                ProgressView("加载中...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if networkService.users.isEmpty {
                VStack(spacing: 10) {
                    Image(systemName: "person.3")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                    Text("暂无用户")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Button("加载用户") {
                        networkService.fetchUsers()
                    }
                    .buttonStyle(.borderedProminent)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(networkService.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        UserRowView(user: user)
                    }
                }
                .refreshable {
                    networkService.fetchUsers()
                }
            }
        }
        .onAppear {
            if networkService.users.isEmpty {
                networkService.fetchUsers()
            }
        }
    }
}

struct UserRowView: View {
    let user: APIUser
    
    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue.opacity(0.7))
                .frame(width: 50, height: 50)
                .overlay(
                    Text(String(user.name.prefix(1)))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                Text("@\(user.username)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(user.email)
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
        .padding(.vertical, 2)
    }
}

struct UserDetailView: View {
    let user: APIUser
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(spacing: 15) {
                    Circle()
                        .fill(Color.blue.opacity(0.7))
                        .frame(width: 100, height: 100)
                        .overlay(
                            Text(String(user.name.prefix(1)))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        )
                    
                    Text(user.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("@\(user.username)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                
                GroupBox("联系信息") {
                    VStack(alignment: .leading, spacing: 10) {
                        Label(user.email, systemImage: "envelope")
                        Label(user.phone, systemImage: "phone")
                        Label(user.website, systemImage: "globe")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                GroupBox("地址") {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("\(user.address.street), \(user.address.suite)")
                        Text("\(user.address.city) \(user.address.zipcode)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                GroupBox("公司") {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(user.company.name)
                            .font(.headline)
                        Text(user.company.catchPhrase)
                            .italic()
                        Text(user.company.bs)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("用户详情")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        NetworkingView()
    }
} 