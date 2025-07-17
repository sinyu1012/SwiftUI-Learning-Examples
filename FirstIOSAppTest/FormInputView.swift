//
//  FormInputView.swift
//  FirstIOSAppTest
//
//  SwiftUI 表单与输入示例
//

import SwiftUI

struct UserProfile {
    var name: String = ""
    var email: String = ""
    var phone: String = ""
    var birthDate = Date()
    var gender = Gender.other
    var favoriteColor = Color.blue
    var bio: String = ""
    var isSubscribed = false
    var preferredLanguage = Language.chinese
    var skill = SkillLevel.beginner
    
    enum Gender: String, CaseIterable {
        case male = "男"
        case female = "女"
        case other = "其他"
    }
    
    enum Language: String, CaseIterable {
        case chinese = "中文"
        case english = "English"
        case japanese = "日本語"
    }
    
    enum SkillLevel: String, CaseIterable {
        case beginner = "初学者"
        case intermediate = "中级"
        case advanced = "高级"
        case expert = "专家"
    }
}

struct FormInputView: View {
    @State private var userProfile = UserProfile()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var rating = 3.0
    @State private var quantity = 1
    @State private var secureText = ""
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            Form {
                // 基本输入
                Section("基本信息") {
                    TextField("姓名", text: $userProfile.name)
                        .textContentType(.name)
                    
                    TextField("邮箱", text: $userProfile.email)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    TextField("电话", text: $userProfile.phone)
                        .textContentType(.telephoneNumber)
                        .keyboardType(.phonePad)
                    
                    SecureField("密码", text: $secureText)
                        .textContentType(.password)
                }
                
                // 日期和选择器
                Section("个人详情") {
                    DatePicker("生日", selection: $userProfile.birthDate, displayedComponents: .date)
                        .datePickerStyle(CompactDatePickerStyle())
                    
                    Picker("性别", selection: $userProfile.gender) {
                        ForEach(UserProfile.Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("首选语言", selection: $userProfile.preferredLanguage) {
                        ForEach(UserProfile.Language.allCases, id: \.self) { language in
                            Text(language.rawValue).tag(language)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                // 滑块和步进器
                Section("偏好设置") {
                    VStack(alignment: .leading) {
                        Text("技能等级")
                        Picker("技能等级", selection: $userProfile.skill) {
                            ForEach(UserProfile.SkillLevel.allCases, id: \.self) { skill in
                                Text(skill.rawValue).tag(skill)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 100)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("评分: \(String(format: "%.1f", rating))")
                        Slider(value: $rating, in: 1...5, step: 0.5)
                    }
                    
                    Stepper("数量: \(quantity)", value: $quantity, in: 1...10)
                    
                    ColorPicker("喜欢的颜色", selection: $userProfile.favoriteColor)
                }
                
                // 开关和文本区域
                Section("其他设置") {
                    Toggle("订阅新闻", isOn: $userProfile.isSubscribed)
                    
                    VStack(alignment: .leading) {
                        Text("个人简介")
                        TextEditor(text: $userProfile.bio)
                            .frame(height: 80)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
                
                // 搜索栏示例
                Section("搜索功能") {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("搜索...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    
                    if !searchText.isEmpty {
                        Text("搜索结果: \(searchText)")
                            .foregroundColor(.secondary)
                    }
                }
                
                // 表单验证示例
                Section("表单验证") {
                    if !userProfile.name.isEmpty && !userProfile.email.isEmpty {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Text("表单已完成")
                                .foregroundColor(.green)
                        }
                    } else {
                        HStack {
                            Image(systemName: "exclamationmark.circle.fill")
                                .foregroundColor(.orange)
                            Text("请完善基本信息")
                                .foregroundColor(.orange)
                        }
                    }
                }
                
                // 提交按钮
                Section {
                    Button("提交表单") {
                        submitForm()
                    }
                    .frame(maxWidth: .infinity)
                    .disabled(userProfile.name.isEmpty || userProfile.email.isEmpty)
                    
                    Button("重置表单") {
                        resetForm()
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("表单示例")
            .alert("提交结果", isPresented: $showAlert) {
                Button("确定", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    private func submitForm() {
        // 简单的表单验证
        if userProfile.name.isEmpty {
            alertMessage = "请输入姓名"
            showAlert = true
            return
        }
        
        if userProfile.email.isEmpty || !userProfile.email.contains("@") {
            alertMessage = "请输入有效的邮箱地址"
            showAlert = true
            return
        }
        
        // 提交成功
        alertMessage = """
        表单提交成功！
        
        姓名: \(userProfile.name)
        邮箱: \(userProfile.email)
        性别: \(userProfile.gender.rawValue)
        语言: \(userProfile.preferredLanguage.rawValue)
        技能: \(userProfile.skill.rawValue)
        评分: \(String(format: "%.1f", rating))
        订阅: \(userProfile.isSubscribed ? "是" : "否")
        """
        showAlert = true
    }
    
    private func resetForm() {
        userProfile = UserProfile()
        rating = 3.0
        quantity = 1
        secureText = ""
        searchText = ""
    }
}

// 自定义输入组件示例
struct CustomInputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isRequired: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.headline)
                if isRequired {
                    Text("*")
                        .foregroundColor(.red)
                }
            }
            
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(text.isEmpty && isRequired ? Color.red : Color.clear, lineWidth: 1)
                )
            
            if text.isEmpty && isRequired {
                Text("此字段为必填项")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}

// 评分组件示例
struct StarRatingView: View {
    @Binding var rating: Int
    let maxRating: Int = 5
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundColor(star <= rating ? .yellow : .gray)
                    .onTapGesture {
                        rating = star
                    }
            }
        }
    }
}

// 标签输入组件示例
struct TagInputView: View {
    @State private var tags: [String] = ["SwiftUI", "iOS", "开发"]
    @State private var newTag = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("标签")
                .font(.headline)
            
            // 显示现有标签
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))], spacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    HStack {
                        Text(tag)
                            .font(.caption)
                        Button(action: {
                            tags.removeAll { $0 == tag }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            
            // 添加新标签
            HStack {
                TextField("添加标签", text: $newTag)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("添加") {
                    if !newTag.isEmpty && !tags.contains(newTag) {
                        tags.append(newTag)
                        newTag = ""
                    }
                }
                .disabled(newTag.isEmpty)
            }
        }
    }
}

#Preview {
    FormInputView()
} 