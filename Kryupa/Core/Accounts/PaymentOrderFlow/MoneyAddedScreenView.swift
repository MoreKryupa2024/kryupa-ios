//
//  MoneyAddedScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 16/07/24.
//

import SwiftUI

struct MoneyAddedScreenView: View {
    @Environment(\.router) var router
    var body: some View {
        ZStack{
            VStack{
                HeaderView(title: "Money Added")
                
                GifImageView("Success")
                    .padding(.horizontal,20)
                    .frame(height: 325)
                VStack(spacing:20){
                    Text("Money has been successfully added\nto your wallet!")
                        .font(.custom(FontContent.plusRegular, size: 12))
                }
                .multilineTextAlignment(.center)
                .foregroundStyle(._444446)
                .padding(.top,50)
                
                Spacer()
            }
        }
        .task{
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                router.dismissScreenStack()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    MoneyAddedScreenView()
}
