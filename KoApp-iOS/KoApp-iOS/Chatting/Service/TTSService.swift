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
    
    /// 언어구별하고 String으로 반환해주기용 언어서비스
    let languageService = LanguageService()
    
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
        let languageCode = languageService.distinguishLanguage(text)
        performSpeak(text, language: languageService.getLanguageCodeString(for: languageCode))
    }

    /// TTS 실행: 읽을 언어 직접 입력
    func speak(_ text: String, _ lang: LanguageCode) {
        performSpeak(text, language: languageService.getLanguageCodeString(for: lang))
    }
}
