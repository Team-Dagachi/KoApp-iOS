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
    let subTopics: [SpeakingSubTopic]
    
    /// 화면에 보여줄 아이콘 이미지 제목
    let icon: String
    
    /// subTopics 완료됐는지 차례대로 Bool값으로 입력된 배열
    /// - !임시! 나중에 바뀔 수도 있음
    /// - 데이터 입력받기 전까지는 랜덤값으로 입력해둠
    let completed: [Bool]
    
    /// 스피킹에 필요한 데이터
    let speakingData: SpeakingData
    

    init(mainTopic: SpeakingTopic, speakingData: SpeakingData = PlistDataLoader.loadSpeakingData()!) {
        self.mainTopic = mainTopic
        // String 형태 데이터 SpeakingSubTopic Enum type으로 바꿔서 초기화시키기
        self.subTopics = speakingData.subTopics[mainTopic.rawValue]?.compactMap { SpeakingSubTopic(rawValue: $0) } ?? []

        self.icon = speakingData.topicIconName[mainTopic.rawValue] ?? ""
        
        var temp: [Bool] = []
        for _ in self.subTopics {
            temp.append(Bool.random())
        }
        self.completed = temp
        
        self.speakingData = speakingData
    }
}
