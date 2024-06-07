//
//  IntroductionScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 15/05/24.
//

import SwiftUI
import SwiftfulUI

struct IntroductionScreenView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
        VStack(spacing: 0.0){
            Spacer()
            Image("Intro1")
                .resizable()
                .frame(width: 305,height: 295)
            
            Text("Connect with trusted caregivers and care seekers in your area.")
                .font(.custom(FontContent.besMedium, size: 25))
                .multilineTextAlignment(.center)
                .padding(.horizontal,24)
                .padding(.top, 66)
                .padding(.bottom, 30)
            
            nextButton
                .padding(.bottom, 34)
                .asButton(.press) {
                    router.showScreen(.push) { _ in
                        UserSelectionScreenView()
                    }
                }
                .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private var nextButton: some View {
        HStack{
            Text("Next")
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
}

#Preview {
    IntroductionScreenView()
}
