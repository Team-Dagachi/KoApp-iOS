//
//  SketchbookItemView.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/2/24.
//

import SwiftUI

struct SketchbookItemView: View {
    /// 입력받을 스피킹 주제
    /// - 이 주제 이용해서 이 뷰에서 쓰일 텍스트, 색상, 이미지 결정됨
    let topic: SpeakingTopic
    
    /// 화면 크기에 따라 입력받을 스케치북의 세로 길이
    let height: CGFloat
    
    /// API에서 입력받을 진행도
    // 일단 랜덤
    let progressValue: Float = Float.random(in: 0...1)
    
    /// 스케치북 제목. 스피킹 주제 제목
    var title: String {
        switch topic {
        case .family:
            "가족"
        case .school:
            "학교"
        case .weatherSeason:
            "날씨와 계절"
        case .travel:
            "여행"
        case .shopping:
            "쇼핑"
        case .media:
            "미디어와 콘텐츠"
        }
    }
    
    /// 아이콘 이미지
    var icon: String {
        switch topic {
        case .family: "ic_home"
        case .school: "ic_school"
        case .weatherSeason: "ic_weather"
        case .travel: "ic_carieer"
        case .shopping: "ic_shoppingBag"
        case .media: "ic_clapboard"
        }
    }
    
    /// 테마 색상
    var progressColor: Color {
        switch topic {
        case .family: .redMedium
        case .school: .orangeMedium
        case .weatherSeason: .pink100
        case .travel: .teal50
        case .shopping: .main100
        case .media: .teal100
        }
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            // 스케치북 종이
            VStack {
                Spacer()
                
                VStack {
                    Text(title)
                        .font(.title3) // TODO: H3
                    
                    Image(icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .background(
                            Circle()
                                .foregroundStyle(Color.gray100)
                                .frame(width: 80, height: 80)
                        )
                        .padding(.top, 12)
                        .padding(.bottom, 24)
                    
                    CustomProgressBar(progressRate: CGFloat(progressValue), tint: progressColor)
                        .padding([.leading, .trailing], 16)
                        .frame(height: 12)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color(red: 0.57, green: 0.59, blue: 0.6).opacity(0.2), radius: 8, x: 0, y: 4)
            .padding(.top, 16)
            
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 16, height: 32)
                    .padding(.leading, 24)
                    .foregroundStyle(progressColor)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 16, height: 32)
                    .padding(.trailing, 24)
                    .foregroundStyle(progressColor)
            }
        }
        .frame(width: .infinity, height: height)
//        .padding(.horizontal)
    }
}

#Preview {
    SketchbookItemView(topic: .travel, height: 210)
}
