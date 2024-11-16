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
    var audioAction:(()-> Void)? = nil
    var nameStr = String()
    @State private var showingAlert = false

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
            
            HStack(spacing: 10) {
                Image("audio")
                    .resizable()
                    .frame(width: 24,height: 24)
                    .asButton(.press) {
                        audioAction?()
                    }
                
                Image("video")
                    .resizable()
                    .frame(width: 24,height: 24)
                    .asButton(.press) {
                        showingAlert = true
                    }
                    .alert("Are you sure you want to start a video call?", isPresented: $showingAlert) {
                        Button("Yes", action: {
                            videoAction?()
                        })
                        Button("No", role: .cancel, action: {})
                    }
            }
            
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 10)
        .background(.white)
    }
}

