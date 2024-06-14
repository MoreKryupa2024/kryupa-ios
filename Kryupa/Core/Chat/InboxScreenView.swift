//
//  InboxScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 14/06/24.
//

import SwiftUI
import SwiftfulUI

struct InboxScreenView: View {
    
    var arrayCount: Int = 6
    @Environment(\.router) var router
    
    var body: some View {
        ZStack{
            VStack(spacing:20){
                HeaderView(title: "Messages")
                
                ScrollView{
                    ForEach(1...arrayCount) { index in
                        SenderView
                            .asButton(.press) {
                                router.showScreen(.push) { rout in
                                    ChatView()
                                }
                            }
                            SepratorView
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var SepratorView: some View{
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.F_2_F_2_F_7)
            .padding(.vertical,10)
            .padding(.horizontal,24)
        
    }
    
    private var SenderView: some View{
        HStack(spacing:0){
            
            Image("profile")
                .resizable()
                .clipShape(Circle())
                .frame(width: 45,height: 45)
            
            VStack(alignment:.leading, spacing:0){
                Text("John Bush")
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.custom(FontContent.plusRegular, size: 16))
                
                Text("New Service Request!")
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundStyle(._7_C_7_C_80)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.leading,12)
            
            Text("9:41 AM")
                .font(.custom(FontContent.plusRegular, size: 13))
                .padding(.top,10)
                .frame(maxHeight: .infinity,alignment: .top)
                .foregroundStyle(._7_C_7_C_80)
            
            Image("chevron-right")
                .resizable()
                .frame(width:17,height: 17)
                .padding(.top,11.5)
                .padding(.leading,11)
                .frame(maxHeight: .infinity,alignment: .top)
            
        }
        .padding(.vertical,9)
        .padding(.horizontal,24)
        
    }
    
}

#Preview {
    InboxScreenView()
}
