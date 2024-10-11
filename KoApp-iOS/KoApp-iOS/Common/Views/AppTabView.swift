//
//  AppTabView.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 8/29/24.
//

import SwiftUI

struct AppTabView: View {
    @State private var activeTab: TabType = .speaking
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // bottom safe area에도 탭바 이어져있는 것처럼 노랑색 채워주기
            Color.main100
                .ignoresSafeArea(edges: .bottom)
            
            // 선택한 탭에 따라 연결될 뷰
            TabView(selection: $activeTab) {
                // TODO: 홈 View 연결
                Text(TabType.home.name)
                    .tag(TabType.home)
                
                // TODO: 숙제 View 연결
                Text(TabType.homework.name)
                    .tag(TabType.homework)

                // 말하기 연습 화면
                SpeakingView()
                    .tag(TabType.speaking)

                // TODO: 생활표현 View 연결
                Text(TabType.expression.name)
                    .tag(TabType.expression)

                // TODO: 노트 View 연결
                Text(TabType.note.name)
                    .tag(TabType.note)
            }
            .padding(.bottom, 1) // bottom safe area 지키미용(이게 맞나)

            // 탭뷰(한땀한땀 수제 제작..)
            ZStack {
                // 배경색 있고 상단부만 Radius 있는 사각형
                Rectangle()
                    .foregroundStyle(Color.main100)
                    .clipShape(
                        RoundedCornersShape(radius: 24, corners: [.topLeft, .topRight])
                    )
                    .frame(height: 80)
                
                // 탭바 본체
                VStack(spacing: 0) {
                    // 아이콘 탭바
                    Tabbar()
                        .overlay { // 강조 효과 적용시키는 부분
                            GeometryReader {
                                let width = $0.size.width
                                let tabCount = CGFloat(TabType.allCases.count)
                                let capsuleWidth = width / tabCount
                                let progress = CGFloat(activeTab.rawValue)
                                
                                Capsule()
                                    .fill(.white.opacity(0.3))
                                    .frame(width: capsuleWidth)
                                    .offset(x: progress * capsuleWidth)
                                
                                
                                Tabbar(.white)
                                    .mask(alignment: .leading) {
                                        Capsule()
                                            .frame(width: capsuleWidth)
                                            .offset(x: progress * capsuleWidth)
                                    }
                            }
                        }
                        .background(.clear)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 10)
                        .padding(.top, 12)
                    
                    // 텍스트 탭바
                    TextTabbar()
                        .padding(.top, 4)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 16)
                }
                
            }
        }
    }
    
    /// 강조 적용될 아이콘 탭바
    @ViewBuilder
    func Tabbar(_ tint: Color = .main20) -> some View {
        HStack(spacing: 0) {
            ForEach(TabType.allCases, id: \.rawValue) { tab in
                Image(tab.icon)
                    .renderingMode(.template)
                    .foregroundStyle(tint)
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity)
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(.snappy(duration: 0.3, extraBounce: 0)) {
                            activeTab = tab
                        }
                    }
            }
        }
    }
    
    /// 텍스트 탭바
    @ViewBuilder
    func TextTabbar() -> some View {
        HStack(spacing: 0) {
            ForEach(TabType.allCases, id: \.rawValue) { tab in
                Text(tab.name)
                    .font(.Button3)
                    .fontWeight(.medium)
                    .foregroundStyle(tab == self.activeTab ? Color.white : Color.main20)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    AppTabView()
}


/// 상단에만 radius 주기 위한 커스텀 shape
struct RoundedCornersShape: Shape {
    var radius: CGFloat = 0.0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

