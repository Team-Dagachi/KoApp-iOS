//
//  Speaking03ViewModel.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/14/24.
//

import Foundation

struct Speaking03ViewModel {
    let subTopic: SpeakingSubTopic
    
    var situation: String {
        switch subTopic {
        case .family_introduce:
            return "나의 가족을 소개해봅시다"
        case .school_teacher:
            return "학교 선생님과 상담을 하려고 해요. 자신의 학교 생활에 대하여 이야기해봅시다."
        case .school_stranger:
            return "처음 보는 학생과 쉬는시간에 대화를 하려고 해요. 학생과 사소한 이야기를 해봅시다."
        case .weatherSeason_weather:
            return "날씨에 대하여 이야기해봅시다."
        case .weatherSeason_Season:
            return "계절에 대해 이야기해봅시다."
        case .travel_plan:
            return "여행 계획에 대하여 이야기해봅시다."
        case .travel_experience:
            return "기억에 남는 여행에 대해 이야기해봅시다"
        case .shopping_cafe:
            return "카페에 가서 주문을 하려고 해요. 직원과 소통하며 대화를 해봅시다."
        case .shopping_cloth:
            return "옷가게에서 쇼핑을 하려고 해요. 직원과 소통하며 대화를 해봅시다."
        case .shopping_mart:
            return "마트에서 장을 보려고 해요. 직원과 소통하며 대화를 해봅시다."
        case .media_kpop:
            return "자신이 좋아하는 K-POP 가수에 대하여 자유롭게 이야기해봅시다."
        case .media_drama:
            return "자신이 좋아하는 한국 드라마에 대하여 자유롭게 이야기해봅시다."
        case .media_game:
            return "자신이 좋아하는 게임에 대하여 자유롭게 이야기해봅시다."
        }
    }
    
    var speakingTips: [String] {
        switch subTopic {
        case .family_introduce:
            return ["가족이 몇 명인지", "가족들이 하는 일", "형제자매 소개하기", "가족과의 추억", "가족과의 일상생활"]
        case .school_teacher:
            return ["학교 생활 적응도", "한국 생활 적응도", "한국어 수업을 들을 때의 어려움", "친구를 사귀는 것에 대한 어려움", "구체적인 장래희망 계획"]
        case .school_stranger:
            return ["숙제 준비 여부", "내일 챙겨야 하는 준비물", "취미와 관심사", "한국어 공부의 어려움", "구체적인 장래희망 계획"]
        case .weatherSeason_weather:
            return ["오늘 날씨", "옷차림 말하기", "날씨로 인한 질병", "좋아하는 날씨"]
        case .weatherSeason_Season:
            return ["좋아하는 계절과 이유", "계절에 할 수 있는 활동", "계절에 선호하는 음식", "싫어하는 계절과 이유"]
        case .travel_plan:
            return ["여행 장소", "여행 일자(언제, 며칠)", "같이 가는 사람", "여행가서 할 일", "가고 싶은 여행지", "그곳으로 여행가는 이유"]
        case .travel_experience:
            return ["여행갔던 장소", "여행 경험", "좋아하는 여행 스타일", "여행지 추천"]
        case .shopping_cafe:
            return ["음료 주문하기", "추천 음료 물어보기", "맛에 대해 물어보기", "사이즈랑 토핑 추가 여부", "결제수단 말하기"]
        case .shopping_cloth:
            return ["쇼핑 목적 말하기", "옷 스타일", "가격, 사이즈 물어보기", "피팅 여부", "할인상품 물어보기"]
        case .shopping_mart:
            return ["무엇을 살 것인지", "할인 중인 상품 물어보기", "요리할 음식을 말하고 재료를 추천받기", "과일 위치 물어보기", "결제 수단 말하기"]
        case .media_kpop:
            return ["좋아하는 K-POP 가수", "좋아하는 노래", "굿즈에 대한 지식", "굿즈를 구매한 경험", "덕질에 대한 지식", "덕질을 해본 경험", "콘서트장 방문 경험"]
        case .media_drama:
            return ["좋아하는 드라마", "좋아하는 영화", "좋아하는 드라마 또는 영화 장르", "좋아하는 배우", "좋아하는 이유", "영화관 방문 경험", "영화관 갈 때 먹는 음식", "영화제에 대한 정보"]
        case .media_game:
            return ["좋아하는 게임", "게임을 좋아하는 이유", "좋아하는 게임 장르", "하루에 게임하는 시간", "좋아하는 프로게이머", "게임 아이템 구매 경험"]
        }
    }
}
