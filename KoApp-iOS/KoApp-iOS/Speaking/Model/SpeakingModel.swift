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
    
    var icon: String {
        switch self {
        case .family: "ic_home"
        case .school: "ic_school"
        case .weatherSeason: "ic_weather"
        case .travel: "ic_carieer"
        case .shopping: "ic_shoppingBag"
        case .media: "ic_clapboard"
        }
    }
}

enum SpeakingSubTopic: String, CaseIterable, Identifiable {
    case family_introduce = "가족 소개하기"
    case school_teacher = "선생님과 대화하기"
    case school_stranger = "처음 보는 학생과 대화하기"
    case weatherSeason_weather = "날씨에 대해 이야기하기"
    case weatherSeason_Season = "계절에 대해 이야기하기"
    case travel_plan = "여행 계획 이야기하기"
    case travel_experience = "여행 경험 이야기하기"
    case shopping_cafe = "카페에서 주문하기"
    case shopping_cloth = "옷가게에서 쇼핑하기"
    case shopping_mart = "마트에서 장보기"
    case media_kpop = "좋아하는 K-POP 가수 말하기"
    case media_drama = "좋아하는 한국 드라마 말하기"
    case media_game = "좋아하는 게임 말하기"
    
    var id: String { self.rawValue }
}
