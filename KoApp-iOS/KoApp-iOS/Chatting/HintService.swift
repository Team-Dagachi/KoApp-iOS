//
//  HintService.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 6/13/24.
//

import SwiftUI
import GoogleGenerativeAI

/// 문장교정용 싱글턴 Gemini API 서비스
@Observable
class HintService {
    private(set) var loadingResponse = false
    
    func requestHint(sentence: String) async -> String? {
        
        loadingResponse = true  // 로딩 시작
        
        do {
            let config = GenerationConfig(
                temperature: 1,
                maxOutputTokens: 50
            )
            
            let model = GenerativeModel(
                name: "gemini-1.5-flash",
                apiKey: APIKey.default,
                generationConfig: config,
                safetySettings: [
                    SafetySetting(harmCategory: .harassment, threshold: .blockOnlyHigh),
                    SafetySetting(harmCategory: .hateSpeech, threshold: .blockOnlyHigh),
                    SafetySetting(harmCategory: .sexuallyExplicit, threshold: .blockOnlyHigh),
                    SafetySetting(harmCategory: .dangerousContent, threshold: .blockOnlyHigh)
                  ],
                // TODO: 모델에 따라 다른 systenInstruction 입력하기
                systemInstruction: "Bạn là người Việt Nam không biết tiếng Hàn. Nếu nhận được câu hỏi bằng tiếng Hàn thì nhất định phải trả lời bằng tiếng Việt. Chúng ta sẽ nói chuyện về địa điểm du lịch, người cùng đi du lịch, kế hoạch du lịch cụ thể… Hãy trả lời đơn giản dưới hai câu. Xin đừng sử dụng biểu tượng cảm xúc khi trả lời."
            )
            
            
            
            // 메시지 보내고 응답받기
            let response = try await model.generateContent(sentence)
            if let text = response.text {
                
                // 불필요한 \n 제거
                let processedText = text.replacingOccurrences(of: "\n", with: "")
                print("processedText:", processedText)
                
                return processedText
                
            }
                        

        }
        catch {
            loadingResponse = false
            print("힌트요청에서 에러났다\n", error.localizedDescription)
        }
        
        return nil
    }
    
    
}


