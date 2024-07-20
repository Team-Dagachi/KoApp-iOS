//
//  APIKey.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 5/31/24.
//

import Foundation

enum APIKey {
    /// Fetch the API key from `GenerativeAI-Info.plist`
    /// This is just *one* way how you can retrieve the API key for your app.
    static var `default`: String {
        // 파일경로 확인
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
        else {
            fatalError("Couldn't find file 'GenerativeAI-Info.plist'.")
        }
        
        // plist 파일에서 API Key 읽기
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
        }
        if value.starts(with: "_") || value.isEmpty {
            fatalError(
                "Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key."
            )
        }
        return value
    }
    
//    /// 번역용 API Key
//    static var `translate`: String {
//        // 파일경로 확인
//        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
//        else {
//            fatalError("Couldn't find file 'GenerativeAI-Info.plist'.")
//        }
//        
//        // plist 파일에서 API Key 읽기
//        let plist = NSDictionary(contentsOfFile: filePath)
//        guard let value = plist?.object(forKey: "API_KEY_TRANSLATE") as? String else {
//            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
//        }
//        if value.starts(with: "_") || value.isEmpty {
//            fatalError(
//                "Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key."
//            )
//        }
//        return value
//    }
}

