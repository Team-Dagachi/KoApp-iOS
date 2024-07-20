//
//  TranslateService.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/15/24.
//

import Alamofire
import Foundation
import SwiftUI

class TranslateService: ObservableObject {
    // MARK: - Properties
    /// 언어 감지하고 바꿔주기 위한 서비스
    let langService: LanguageService = .init()
        
    /// 번역된 텍스트
    @Published var translatedText: String = ""
    
//    /// 피드백일 경우, 바꾼 이유 번역된 텍스트
//    @Published var reasonTranslated: String? = ""
    
    
    // MARK: - Methods
    /// 텍스트 받아서 번역 수행하는 대표함수
    func translateText(text: String) {
        
        // 언어 감지, 반환: from 언어와 to 언어
        let languageSet = detectAndSwitchLanguage(text: text)
               
        // 번역 요청할 URL 생성
        let finalURL = makeURL(from: languageSet.from, to: languageSet.to, text: text)
        
        // Alamofire를 사용한 HTTP 요청
        fetchTranslations(url: finalURL)
    }
    
    /// Alamofire 이용해서 번역 요청하는 함수
    func fetchTranslations(url: String) {
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                
                if let jsonArray = value as? [Any], let firstElement = jsonArray.first as? [Any] {
                    
                    // 번역된 텍스트 항목만 골라서 String 배열로 만들어주기
                    let firstTexts = firstElement.compactMap { item in
                        (item as? [Any])?.first as? String  // item을 배열로 캐스팅 후 첫 번째 요소 반환
                    }
                    
                    self.translatedText = firstTexts.joined()
                    print("translatedText: \(self.translatedText)")

                } else {
                    print("Failed to parse the translation response.")
                }
            case .failure(let error):
                print("Error while fetching data: \(error)")
            }
        }
    }
    
    /// 입력받은 텍스트의 언어와, 그 텍스트의 언어를 어떤 언어로 번역할지 반환하는 함수
    func detectAndSwitchLanguage(text: String) -> (from: String, to: String) {
        // 언어감지
        let textLanguageCode = langService.distinguishLanguage(text)
        
        // 언어코드 string값으로 바꾸기
        let selected_language = langService.getLanguageCodeString(for: textLanguageCode)
        
        // 감지된 언어 바탕으로 번역할 언어도 찾기
        let target_language = langService.getLanguageCodeString(for: langService.switchLanguage(target: textLanguageCode))
        
        return (from: selected_language, to: target_language)
    }
    
    /// 구글 번역에 필요한 URL 만들어주는 함수
    func makeURL(from selected_language: String, to target_language: String, text: String) -> String {
        // URL 인코딩
        let baseGoogleUrl = "https://translate.googleapis.com/translate_a/single?client=gtx"
        let query = "&sl=\(selected_language)&tl=\(target_language)&dt=t&q=\(text)"
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        // 최종 URL 생성
        return baseGoogleUrl + encodedQuery
    }
    
}

// MARK: - getter & setter
extension TranslateService {
    
    /// getter: translatedText
    func getTranslatedText() -> String {
        return self.translatedText
    }

    
    /// setter: translatedText
    func setTranslatedText(to text: String) {
        self.translatedText = text
    }
    
//    /// setter: reasonTranslated
//    func setReasonTranslated(to text: String) {
//        self.reasonTranslated = text
//    }
}
