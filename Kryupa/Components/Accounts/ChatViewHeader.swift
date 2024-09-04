//
//  ChatViewHeader.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 03/09/24.
//

import SwiftUI
import SwiftfulUI

struct UserNameView:  View{
    
    var backAction:(()-> Void)? = nil
    var videoAction:(()-> Void)? = nil
    var nameStr = String()
    
    var body: some View {
        HStack(spacing: 10) {
            Image("navBack")
                .resizable()
                .frame(width: 30,height: 30)
                .asButton(.press) {
                    backAction?()
                }
            
            Text(nameStr)
                .lineLimit(1)
                .font(.custom(FontContent.besRegular, size: 20))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Image("video")
                    .resizable()
                    .frame(width: 24,height: 24)
                    .asButton(.press) {
                        videoAction?()
                    }
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 10)
        .background(.white)
    }
}

