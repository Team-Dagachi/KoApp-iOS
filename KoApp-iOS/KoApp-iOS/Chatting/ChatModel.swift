//
//  ChattingModel.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 5/31/24.
//

import Foundation

enum ChatRole {
    case user       // 유저가 말한 문장
    case model      // Gemini가 이어서 대답한 문장
    case feedback    // 고친 문장
    case hint       // 힌트
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID().uuidString
    var role: ChatRole
    var message: String
    
    /// 말풍선이 화면에 보일지 안보일지를 결정하는 변수
    var isShowing: Bool
    
    /// 문장검사 결과 저장할 변수
    /// - role이 .user일 때만 값이 존재
    var isNatural: Bool?
    
    /// 고친 이유 설명하는 문장이 저장될 변수
    /// - role이  .feedback일 때만 값이 존재
    var reasonForChange: String?
    
    init(role: ChatRole, message: String, isNatural: Bool? = nil, reasonForChange: String? = nil) {
        self.role = role
        self.message = message
        self.isShowing = true /*(role == .model || role == .user || role == .hint)*/
        self.isNatural = isNatural
        self.reasonForChange = reasonForChange
    }
}
