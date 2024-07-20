//
//  LangageService.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/20/24.
//

import Foundation

/// 한국어, 베트남어, 중국어 구분하는 언어 코드
enum LanguageCode {
    case ko
    case viet
    case ch
}

struct LanguageService {
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
    func getLanguageCodeString(for lang: LanguageCode) -> String {
        switch lang {
        case .ko:
            return "ko-KR"
        case .viet:
            return "vi-VN"
        case .ch:
            return "zh-CN"
        }
    }
    
    /// 번역될 언어를 입력하면 번역할 언어를 출력
    // TODO: 언어 추가되면 로직 수정하기
    func switchLanguage(target: LanguageCode) -> LanguageCode {
        if target == .viet {
            return .ko
        } else if target == .ko {
            return .viet
        } else { return .ko }
    }
}

