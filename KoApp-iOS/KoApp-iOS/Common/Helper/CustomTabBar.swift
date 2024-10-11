//
//  CustomTabBar.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 8/29/24.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedIndex: Int
    let tabItems: [(String, String)]
    
    var body: some View {
        HStack {
            ForEach(0..<tabItems.count, id: \.self) { index in
                Button(action: {
                    withAnimation {
                        selectedIndex = index
                    }
                }) {
                    VStack {
                        Image(systemName: tabItems[index].1)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(selectedIndex == index ? .white : .gray)
                        Text(tabItems[index].0)
                            .font(.caption)
                            .foregroundColor(selectedIndex == index ? .white : .gray)
                    }
                    .padding()
                    .background(selectedIndex == index ? Color.yellow : Color.clear)
                    .cornerRadius(10)
                }
            }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(Color.yellow.edgesIgnoringSafeArea(.all))
        .cornerRadius(20)
    }
}

#Preview {
    CustomTabBar(selectedIndex: .constant(1), tabItems: [
        ("홈", "house.fill"),
        ("숙제", "calendar"),
        ("말하기연습", "person.3.fill"),
        ("생활표현", "creditcard.fill"),
        ("노트", "star.fill")
    ])
}

enum TabType: Int, CaseIterable {
//    ("홈", "tab_home"),
//    ("숙제", "tab_homework"),
//    ("말하기연습", "tab_speaking"),
//    ("생활표현", "tab_expression"),
//    ("노트", "tab_note")
    case home
    case homework
    case speaking
    case expression
    case note
    
    var icon: String {
        switch self {
        case .home:
            "tab_home"
        case .homework:
            "tab_homework"
        case .speaking:
            "tab_speaking"
        case .expression:
            "tab_expression"
        case .note:
            "tab_note"
        }
    }
    
    var name: String {
        switch self {
        case .home:
            "홈"
        case .homework:
            "숙제"
        case .speaking:
            "말하기연습"
        case .expression:
            "생활표현"
        case .note:
            "노트"
        }
    }
}
