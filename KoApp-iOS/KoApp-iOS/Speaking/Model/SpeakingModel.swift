//
//  SpeakingModel.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/2/24.
//

import Foundation

enum SpeakingTopic: CaseIterable, Identifiable {
    /// 가족
    case family
    /// 학교
    case school
    /// 날씨와 계절
    case weatherSeason
    /// 여행
    case travel
    /// 쇼핑
    case shopping
    /// 미디어와 콘텐츠
    case media
    
    var id: UUID { UUID() }
}

enum SpeakingSubTopic: CaseIterable, Identifiable {
    // family
    /// 가족 소개하기
    case family_introduce
    
    // school
    /// 선생님과 대화하기
    case school_teacher
    /// 처음 보는 학생과 대화하기
    case school_stranger
    
    // weatherSeason
    /// 날씨에 대해 이야기하기
    case weatherSeason_weather
    /// 계절에 대해 이야기하기
    case weatherSeason_Season
    
    // travel
    /// 여행 계획 이야기하기
    case travel_plan
    /// 여행 경험 이야기하기
    case travel_experience
    
    // shopping
    /// 카페에서 주문하기
    case shopping_cafe
    /// 옷가게에서 쇼핑하기
    case shopping_cloth
    /// 마트에서 장보기
    case shopping_mart
    
    // media
    /// 좋아하는 K-POP 가수 말하기
    case media_kpop
    /// 좋아하는 한국 드라마 말하기
    case media_drama
    /// 좋아하는 게임 말하기
    case media_game
    
    var id: UUID { UUID() }
}
