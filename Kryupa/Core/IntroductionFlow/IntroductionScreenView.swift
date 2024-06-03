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
            
            Text("Lorem ipsum dolor sit amet consectetur.")
                .font(.custom(FontContent.besMedium, size: 34))
                .multilineTextAlignment(.center)
                .frame(width: 249)
                .lineSpacing(0)
                .padding(.top, 66)
            
            
            Text("Lorem ipsum dolor sit amet consectetur.")
                .font(.custom(FontContent.plusRegular, size: 13))
                .foregroundStyle(._7_C_7_C_80)
                .multilineTextAlignment(.center)
                .frame(width: 223, height: 36)
                .padding([.top,.bottom], 15)
            
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
