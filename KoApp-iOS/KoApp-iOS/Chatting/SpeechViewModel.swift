//
//  SpeechViewModel.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 6/7/24.
//

import SwiftUI
import Speech
import AVFoundation

class SpeechViewModel: ObservableObject {
    private var speechRecognizer = SFSpeechRecognizer()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private var audioEngine = AVAudioEngine()

    @Published var isRecording = false
    @Published var recognizedText = ""

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
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionTask?.cancel()

        withAnimation {
            isRecording = false
        }
    }
    
}
