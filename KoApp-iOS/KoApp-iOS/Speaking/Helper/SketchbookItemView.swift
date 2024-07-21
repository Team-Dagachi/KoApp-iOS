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
        
    /// 아이콘 이미지
    var icon: String {
        SpeakingData.topicIconName[topic] ?? ""
    }
    
    /// 테마 색상
    var tint: Color {
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
                
                Text(SpeakingData.topicName[topic] ?? "주제")
                    .font(.H3)
                    .foregroundStyle(Color.gray700)
                    .padding(.top, (self.height < 210) ? 20 : 0) // 스케치북 길이가 짧을 때 '미디어와 콘텐츠'가 클립이랑 안겹치도록
                
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
                
                CustomProgressBar(progressRate: CGFloat(progressValue), tint: self.tint)
                    .padding([.leading, .trailing], 16)
                    .padding(.bottom, 16)
                    .frame(height: 12)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: Color(red: 0.57, green: 0.59, blue: 0.6).opacity(0.2), radius: 8, x: 0, y: 4)
            .padding(.top, 16) // 클립의 절반 밑으로 스케치북 종이 보이도록
            
            // 스케치북 클립(?)
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 16, height: 32)
                    .padding(.leading, 24)
                    .foregroundStyle(tint)
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 16, height: 32)
                    .padding(.trailing, 24)
                    .foregroundStyle(tint)
            }
        }
        .frame(maxWidth: .infinity,
               // 최대한 210에 맞춰봄
               minHeight: height < 210 ? height : 210,
               maxHeight: height > 210 ? height : 210)
        .padding(.horizontal, 6)
    }
}

#Preview {
    SketchbookItemView(topic: .travel, height: 210)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.black)
}
