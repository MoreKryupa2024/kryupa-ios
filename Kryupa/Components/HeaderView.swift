//
//  HeaderView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI
import SwiftfulUI

struct HeaderView: View {
    
    @Environment(\.router) var router
    
    var title = ""
    var showBackButton = false
    
    var body: some View {
        
        VStack(spacing: 24) {
            ZStack{
                Image("KryupaLobby")
                    .resizable()
                    .frame(width: 124,height: 20)
                
                HStack{
                    if showBackButton {
                        Image("navBack")
                            .resizable()
                            .frame(width: 30,height: 30)
                            .asButton(.press) {
                                router.dismissScreen()
                            }
                    }
                    
                    Spacer()
                    Image("NotificationBellIcon")
                        .frame(width: 25,height: 25)
                }
                .padding(.horizontal,24)
            }
            
            if title != "" {
                Text(title)
                    .font(.custom(FontContent.besMedium, size: 20))
                    .foregroundStyle(.appMain)
            }
        }
        .padding(.top, 10)
        
    }
}

#Preview {
    HeaderView()
}
