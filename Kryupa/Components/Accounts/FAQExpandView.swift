//
//  FAQExpandView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI

struct FAQExpandView: View {
    @State var isExpanded = false
    var data: AboutUsData
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(data.title)
                    .foregroundStyle(._242426)
                    .font(.custom(FontContent.plusRegular, size: 17))
                Spacer()
                Image(!isExpanded ? "chevron-down" : "chevron-up")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            if isExpanded {
                Text(data.desc)
                    .foregroundStyle(._7_C_7_C_80)
                    .font(.custom(FontContent.plusRegular, size: 15))
                
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
        .transition(.move(edge: .bottom))
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .padding(.horizontal, 24)
    }
}
