//
//  Speaking02Row.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/7/24.
//

import SwiftUI

struct Speaking02Row: View {
    /// 학습여부 체크표시용
    let isCompleted: Bool
    
    /// 말하기 상황주제 텍스트
    /// - ex) 여행 계획 이야기하기
    /// - ex) 좋아하는 한국 드라마 말하기
    let subTopic: String
    
    var body: some View {
        HStack {
            Image(isCompleted ? "ic_check_fill" : "ic_check_grey")
            Text(subTopic)
                .font(.H4)
            Spacer()
            Image("ic_chevron_right")
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 40)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.white)
                .shadow(color: Color(red: 0.57, green: 0.59, blue: 0.6).opacity(0.2), radius: 8, x: 0, y: 4)
        )
    }
}

#Preview {
    ZStack {
        Color.yellow
        
        Speaking02Row(isCompleted: true, subTopic: "여행 계획 이야기하기")
    }
}
