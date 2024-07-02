//
//  CustomProgessView.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/2/24.
//

import SwiftUI

struct CustomProgressBar: View {
    
    var progressRate: CGFloat
    var tint: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.gray)
                    .opacity(0.3)
                    .frame(width: geometry.size.width, height: 12)
                Rectangle()
                    .foregroundColor(tint)
                    .frame(width: geometry.size.width * self.progressRate,
                           height: 12)
            }
            .frame(width: geometry.size.width, height: 12)
            .cornerRadius(12 / 2.0)
        }
    }
}
