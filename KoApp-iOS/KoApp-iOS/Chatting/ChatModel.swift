//
//  ChattingModel.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 5/31/24.
//

import Foundation

enum ChatRole {
    case user
    case model
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID().uuidString
    var role: ChatRole
    var message: String
}
