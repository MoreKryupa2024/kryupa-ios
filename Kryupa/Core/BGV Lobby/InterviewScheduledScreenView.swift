//
//  InterviewScheduledScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 29/05/24.
//

import SwiftUI
import SwiftfulRouting

struct InterviewScheduledScreenView: View {
    
    @Environment(\.router) var router
    var selectedSlotID: String = "cfbbe5bc-d016-447b-8336-d12a6a0ebca6"
    @StateObject private var viewModel = LobbyScreenViewModel()
    
    var body: some View {
        ScrollView{
            VStack(spacing:0){
                
                Text("Interview Scheduled")
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .font(.custom(FontContent.besMedium, size: 28))
                    .padding(.top,65)
                
                ////LottieView(animationFileName: "SuccessLottie", loopMode: .loop)
                GifImageView("Success")
                    .padding(.horizontal,20)
                    .frame(height: 325)
                
                Text("You will get reminder notification before 15mins of meeting")
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .multilineTextAlignment(.center)
                    .frame(width: 270)
                    .padding(.top,65)
                
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                            router.dismissScreenStack()
                        }
                    }
            }
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
        .task {
            viewModel.bookSlot(id: selectedSlotID)
        }
    }
}

#Preview {
    InterviewScheduledScreenView()
}
