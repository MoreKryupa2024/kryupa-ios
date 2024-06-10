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
                    completeProfileView
                    jobsNearYouView
//                    BannerView(showIndecator: false,bannerHeight: 104)
//                        .padding([.horizontal,.vertical],24)
//                    noCotentView
                }
            }
            .scrollIndicators(.hidden)
            .toolbar(.hidden, for: .navigationBar)
        }
        .task {
            
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
    
    private var completeProfileView: some View{
        HStack {
            Text("Complete your profile")
                .font(.custom(FontContent.plusRegular, size: 15))
                .foregroundStyle(._444446)
                .padding(.leading, 15.0)
                .frame(height: 20)
            
            Spacer()

            Text("45% Completed")
                .padding(.horizontal, 5)
                .font(.custom(FontContent.plusRegular, size: 12))
                .minimumScaleFactor(0.01)
                .frame(height: 20)
                .withBackground(color: ._242426,cornerRadius: 30)
                .foregroundStyle(.white)
                .padding(.trailing, 15.0)
        }
        .frame(height: 40)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .padding(.top, 21)
        .padding(.horizontal, 21)
    }
    
    private var jobsNearYouView: some View{
        VStack(spacing:10){
            HStack{
                Text("Jobs Near You")
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundColor(Color("242426"))
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                    Text("See All")
                        .font(.custom(FontContent.plusRegular, size: 13))
                        .foregroundStyle(._7_C_7_C_80)
            }
            .padding(.horizontal,24)
            jobsNearYouGridView
        }
        .padding(.top, 21)

    }
    
    private var jobsNearYouGridView: some View{
                
        ScrollView(.horizontal) {
            HStack(spacing:1){
                ForEach(1...3) { index in
                    CareGiverPortfolioView()
                        .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                            view.scaleEffect(phase.isIdentity ? 1 : 0.85)
                        }
                }
            }
            .padding(.horizontal, 53)
        }
        .scrollIndicators(.hidden)
    }
    
    struct ViewHeightKey: PreferenceKey {
        static var defaultValue: CGFloat { 0 }
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value = value + nextValue()
        }
    }
    
    struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value += nextValue()
        }
    }
}

#Preview {
    CareGiverHomeScreenView()
}
