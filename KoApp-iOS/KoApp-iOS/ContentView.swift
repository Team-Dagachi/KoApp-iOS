//
//  ContentView.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 5/25/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // TODO: 초기화면으로 변경하기
        // 일단은 Speaking으로 초기화면 설정해두고, 나중에 개발 진행되면 진행되는대로 바꾸는걸로~_~
        NavigationStack {
            SpeakingView()
        }
        // 이전 버튼(<) 검은색으로
        .tint(Color.black)
        .task {
            print("ContentView OPENED")
        }
    }
}

#Preview {
    ContentView()
}
