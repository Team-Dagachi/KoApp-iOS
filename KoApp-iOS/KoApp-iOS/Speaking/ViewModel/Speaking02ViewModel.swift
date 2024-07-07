//
//  Speaking02ViewModel.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/7/24.
//


struct Speaking02ViewModel {
    /// 스피킹 메인 주제
    let mainTopic: SpeakingTopic
    
    /// 스키핑 메인 주제에 따라 결정되는 서브주제
    var subTopics: [SpeakingSubTopic] {
        switch mainTopic {
        case .family:
            return [.family_introduce]
        case .school:
            return [.school_teacher, .school_stranger]
        case .weatherSeason:
            return [.weatherSeason_weather, .weatherSeason_Season]
        case .travel:
            return [.travel_plan, .travel_experience]
        case .shopping:
            return [.shopping_cafe, .shopping_cloth, .shopping_mart]
        case .media:
            return [.media_kpop, .media_drama, .media_game]
        }
    }
    
    /// subTopics 완료됐는지 차례대로 Bool값으로 입력된 배열
    /// - !임시! 나중에 바뀔 수도 있음
    /// - 데이터 입력받기 전까지는 랜덤값으로 입력해둠
    var completed: [Bool] {
        var temp: [Bool] = []
        for _ in self.subTopics {
            temp.append(Bool.random())
        }
        return temp
    }
}
