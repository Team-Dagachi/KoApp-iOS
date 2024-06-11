//
//  SpeechViewModel.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 6/7/24.
//

import SwiftUI
import Speech
import AVFoundation

/// Apple Speech 이용해 STT 수행 
class SpeechViewModel: ObservableObject {
    private var speechRecognizer = SFSpeechRecognizer()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioEngine = AVAudioEngine()

    @Published var isRecording = false
    @Published var recognizedText = ""
    
    init() {
        requestAuthorization()
    }
    
    func requestAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            DispatchQueue.main.async {
                switch authStatus {
                case .authorized:
                    print("Speech recognition authorized")
                case .denied:
                    print("Speech recognition denied")
                case .restricted:
                    print("Speech recognition restricted")
                case .notDetermined:
                    print("Speech recognition determined")
                @unknown default:
                    fatalError()
                }
            }
        }
        
        AVAudioSession.sharedInstance().requestRecordPermission { granted in
            DispatchQueue.main.async {
                if granted {
                    print("Microphone access granted")
                } else {
                    print("Microphone access denied")
                }
            }
        }
    }

    func startRecording() {
        guard !audioEngine.isRunning else {
            stopRecording()
            return
        }

        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            let inputNode = audioEngine.inputNode

            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            guard let recognitionRequest = recognitionRequest else { return }
            recognitionRequest.shouldReportPartialResults = true

            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                if let result = result {
                    self.recognizedText = result.bestTranscription.formattedString
                }

                if let error = error {
                    print("Recognition error: \(error.localizedDescription)")
                    self.stopRecording()
                }
            }

            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
                recognitionRequest.append(buffer)
            }

            audioEngine.prepare()
            try audioEngine.start()

            withAnimation {
                isRecording = true
            }
        } catch {
            print("Failed to start recording: \(error.localizedDescription)")
            stopRecording()
        }
    }

    func stopRecording() {
        audioEngine.inputNode.removeTap(onBus: 0)   // 오디오 입력 노드에서 설치된 탭 제거
        audioEngine.stop()  // 오디오 엔진 중지

        // 인식 요청에 더이상 오디오 보내지 않음 알려주기
        if let recognitionRequest = self.recognitionRequest {
            recognitionRequest.endAudio()
        }  else {
            print("recognitionRequest is already nil")
        }
        
        // 현재 진행 중인 인식 작업 취소
        if let recognitionTask = self.recognitionTask {
            recognitionTask.cancel()
        } else {
            print("recognitionTask is already nil")
        }

        withAnimation {
            isRecording = false
        }
    }
    
}
