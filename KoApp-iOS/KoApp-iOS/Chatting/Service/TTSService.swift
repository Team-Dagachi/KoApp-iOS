//
//  TTSService.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 6/30/24.
//

import SwiftUI
import Foundation
import AVFoundation

class TTSService: NSObject, AVSpeechSynthesizerDelegate, ObservableObject {
    
    private let synthesizer = AVSpeechSynthesizer()
    
    /// 스피킹이 실행되고 있는지 확인하는 Published 변수
    @Published var isSpeaking: Bool = false
    
    /// 한국어, 베트남어, 중국어 구분하는 언어 코드
    enum LanguageCode {
        case ko
        case viet
        case ch
    }
    
    override init() {
        super.init()
        synthesizer.delegate = self
    }
    
    private func setupAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set audio session: \(error.localizedDescription)")
        }
    }
    
    /// 베트남어, 한국어, 중국어 구별
    func distinguishLanguage(_ text: String) -> LanguageCode {
        // 한국어, 중국어, 베트남어에 해당하는 유니코드 범위 및 세트 정의
        let koreanRange = 0xAC00...0xD7AF
        let chineseRange = 0x4E00...0x9FFF
        let vietnameseDiacritics: Set<Character> = ["à", "á", "ả", "ã", "ạ", "ă", "ằ", "ắ", "ẳ", "ẵ", "ặ", "â", "ầ", "ấ", "ẩ", "ẫ", "ậ", "è", "é", "ẻ", "ẽ", "ẹ", "ê", "ề", "ế", "ể", "ễ", "ệ", "ì", "í", "ỉ", "ĩ", "ị", "ò", "ó", "ỏ", "õ", "ọ", "ô", "ồ", "ố", "ổ", "ỗ", "ộ", "ơ", "ờ", "ớ", "ở", "ỡ", "ợ", "ù", "ú", "ủ", "ũ", "ụ", "ư", "ừ", "ứ", "ử", "ữ", "ự", "ỳ", "ý", "ỷ", "ỹ", "ỵ", "đ"]

        for scalar in text.unicodeScalars {
            if koreanRange.contains(Int(scalar.value)) {
                return .ko
            } else if chineseRange.contains(Int(scalar.value)) {
                return .ch
            } else if vietnameseDiacritics.contains(Character(scalar)) {
                return .viet
            }
        }

        // 언어를 판별할 수 없는 경우 한국어로 기본값 반환
        return .ko
    }
    
    /// 언어 코드에 맞는 문자열 반환
    private func languageCode(for lang: LanguageCode) -> String {
        switch lang {
        case .ko:
            return "ko-KR"
        case .viet:
            return "vi-VN"
        case .ch:
            return "zh-CN"
        }
    }
    
    // TTS 실행
    /// Common function to set up and speak
    func performSpeak(_ text: String, language: String) {
        guard !text.isEmpty else {
            print("Text field is empty")
            return
        }
        
        setupAudioSession()

        // Create an utterance
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate

        // Speak
        synthesizer.speak(utterance)
        withAnimation {
            isSpeaking = true // tts 시작
        }
    }
    
    // MARK: - AVSpeechSynthesizerDelegate
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        withAnimation {
            isSpeaking = false // tts 종료
        }
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        withAnimation {
            isSpeaking = false // tts 종료
        }
    }
    
    /// TTS 실행: 언어 구분 필요할 때
    func speak(_ text: String) {
        let languageCode = distinguishLanguage(text)
        performSpeak(text, language: self.languageCode(for: languageCode))
    }

    /// TTS 실행: 읽을 언어 직접 입력
    func speak(_ text: String, _ lang: LanguageCode) {
        performSpeak(text, language: self.languageCode(for: lang))
    }
}
