//
//  Speaking03ViewModel.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/14/24.
//

import Foundation

struct Speaking03ViewModel {
    /// 대화 주제
    let subTopic: SpeakingSubTopic
    
    /// 대화주제별 상황 설명 텍스트
    let situation: String
    
    /// 대화 팁
    let speakingTips: [String]
    
    
    init(subTopic: SpeakingSubTopic) {
        self.subTopic = subTopic
        self.situation = SpeakingData.situations[subTopic] ?? ""
        self.speakingTips = SpeakingData.tips[subTopic] ?? []
    }
}
