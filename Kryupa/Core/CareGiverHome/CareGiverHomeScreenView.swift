//
//  CareGiverHomeScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 30/05/24.
//

import SwiftUI

struct CareGiverHomeScreenView: View {
    var body: some View {
        VStack(spacing:0){
            HeaderView
            ScrollView{
                VStack(spacing:0){
                    BannerView(showIndecator: false,bannerHeight: 104)
                        .padding([.horizontal,.vertical],24)
                    noCotentView
                }
            }
            .scrollIndicators(.hidden)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private var noCotentView: some View{
        
        VStack(spacing:0){
            Text("Waiting for care seekers?\nNo Worries! Refer and Earn")
                .font(.custom(FontContent.besMedium, size: 20))
                .multilineTextAlignment(.center)
            
            HStack{
                Text("Win Upto")
                Text("$5")
                    .strikethrough()
                Text("$25")
            }
            .foregroundStyle(.white)
            .padding(.vertical,5)
            .padding(.horizontal,10)
            .background{
                RoundedRectangle(cornerRadius: 5)
            }
            .font(.custom(FontContent.besMedium, size: 17))
            .padding(.top,10)
            
            Image("emptyHome")
                .resizable()
                .frame(width: 185,height: 206)
                .padding(.top,30)
            
            nextButton
                .padding(.vertical,30)
        }
    }
    
    private var nextButton: some View {
        HStack{
            Text("Refer Now")
                .font(.custom(FontContent.plusMedium, size: 16))
                .padding([.top,.bottom], 16)
                .padding([.leading,.trailing], 40)
        }
        .background(
            ZStack{
                Capsule(style: .circular)
                    .fill(.appMain)
            }
        )
        .foregroundColor(.white)
    }
    
    private var HeaderView: some View{
        ZStack{
            Image("KryupaLobby")
                .resizable()
                .frame(width: 124,height: 20)
            
            HStack{
                Spacer()
                Image("NotificationBellIcon")
                    .frame(width: 25,height: 25)
            }
            .padding(.horizontal,24)
        }
    }
}

#Preview {
    CareGiverHomeScreenView()
}
