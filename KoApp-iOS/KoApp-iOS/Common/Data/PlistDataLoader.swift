//
//  PlistDataLoader.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/28/24.
//

import Foundation

class PlistDataLoader {
    static func loadSpeakingData() -> SpeakingData? {
        guard let url = Bundle.main.url(forResource: "SpeakingData", withExtension: "plist"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }

        let decoder = PropertyListDecoder()
        do {
            let speakingData = try decoder.decode(SpeakingData.self, from: data)
            return speakingData
        } catch {
            print("Error decoding Plist data: \(error)")
            return nil
        }
    }
}
