//
//  SpeakingModel.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/2/24.
//

import Foundation

enum SpeakingTopic: String, CaseIterable, Identifiable {
    case family = "가족"
    case school = "학교"
    case weatherSeason = "날씨와 계절"
    case travel = "여행"
    case shopping = "쇼핑"
    case media = "미디어와 콘텐츠"
    
    var id: String { self.rawValue }
}
