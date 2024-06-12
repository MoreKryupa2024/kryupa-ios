//
//  ReviewCell.swift
//  Kryupa
//
//  Created by Pooja Nenava on 12/06/24.
//

import SwiftUI

struct ReviewCell: View {
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image("reviewUser")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)

                VStack(alignment: .leading) {
                    Text("Carla Carder")
                        .font(.custom(FontContent.besMedium, size: 15))
                        .foregroundStyle(.appMain)
                    Text("3rd March ")
                        .font(.custom(FontContent.plusRegular, size: 12))
                        .foregroundStyle(._444446)
                    HStack {
                        ForEach (0...3) {_ in 
                            Image("star")
                                .frame(width: 12, height: 12)
                        }
                    }
                }
                
                Spacer()
            }
            
            Text("Lorem ipsum dolor sit amet consectetur. Tempus commodo cursus libero nullam vitae. Tempus neque duis enim tellus tortor elit eu commodo netus.")
                .font(.custom(FontContent.plusRegular, size: 12))
                .foregroundStyle(._444446)
                .padding(.top, 5)

        }
        .padding(.horizontal, 14)
        .padding(.vertical, 11)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
}

#Preview {
    ReviewCell()
}
