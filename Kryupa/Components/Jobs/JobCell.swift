//
//  JobCell.swift
//  Kryupa
//
//  Created by Pooja Nenava on 17/06/24.
//

import SwiftUI

struct JobCell: View {
    var body: some View {
        HStack {
            Image("giveReview")
                .resizable()
                .frame(width: 63, height: 63)
                .cornerRadius(31)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Tiana Gouse")
                        .font(.custom(FontContent.besMedium, size: 17))
                        .foregroundStyle(.appMain)

                    Spacer()
                    
                    Text("$252")
                        .font(.custom(FontContent.plusMedium, size: 12))
                        .foregroundStyle(.appMain)
                }
                
                Text("3rd March - 5th March 2024")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)

                Text("Companionship")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._444446)
            }

        }
        .frame(height: 81)
        .padding(.horizontal, 10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .padding(.horizontal, 24)
        
    }
}

#Preview {
    JobCell()
}
