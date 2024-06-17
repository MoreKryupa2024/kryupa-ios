//
//  ReviewHoursView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 17/06/24.
//

import SwiftUI

struct ReviewHoursView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Rate per hour:")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
                
                Spacer()
                
                Text("$20.23")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
            }
            
            HStack {
                Text("Number of hours:")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
                
                Spacer()
                
                Text("6")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
            }
            
            HStack {
                Text("Total:")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
                
                Spacer()
                
                Text("$121.38")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
            }
        }
        .padding([.horizontal, .top], 24)
    }
}

#Preview {
    ReviewHoursView()
}
