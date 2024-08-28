//
//  BGVTimeSlotScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 28/05/24.
//

import SwiftUI
import SwiftfulUI

struct BGVTimeSlotScreenView: View {
    @Environment(\.router) var router
    @StateObject private var viewModel = BGVTimeSlotScreenViewModel()
    
    var body: some View {
        ZStack{
            VStack(spacing:0){
                HeaderView
                WeakDayContentView
                    .frame(height: 64)
                
                ScrollView {
                    VStack(spacing:0){
                        ForEach(viewModel.availableSlotsList, id: \.id) { slot in
                            
                            AvailableTimeSlotsView(
                                isSelected: viewModel.selectedSlotID == slot.id,
                                availablityTime: "\(slot.startingTime.convertDateFormater(beforeFormat: "HH:mm:ss.SSS", afterFormat: "h:mm a")) - \(slot.endTime.convertDateFormater(beforeFormat: "HH:mm:ss.SSSs", afterFormat: "h:mm a"))"
                            )
                            .asButton {
                                viewModel.selectedSlotID = slot.id
                            }
                        }
                    }
                    .padding(.top,20)
                }
                .padding([.top,.horizontal],24)
                .scrollIndicators(.hidden)
                .toolbar(.hidden, for: .navigationBar)
                
                nextButton
                    .padding(.vertical,27)
                    .asButton(.press) {
                        router.showScreen(.push) { _ in
                            InterviewScheduledScreenView(selectedSlotID: viewModel.selectedSlotID)
                        }
                    }
            }
            
            if viewModel.isloading{
                LoadingView()
            }
        }
        .onAppear {
            viewModel.getSlotList()
        }
    }
    
    private var nextButton: some View {
        HStack{
            Text("Schedule Interview")
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
    
    private var WeakDayContentView: some View{
        WeakDayView(selectedValue: viewModel.selectedDay){ selectedWeak in
            viewModel.selectedDay = selectedWeak
            viewModel.getSlotList()
        }
        .padding(.horizontal,24)
        .padding(.top,24)
    }
    
    private var HeaderView: some View{
        ZStack{
            Image("KryupaLobby")
                .resizable()
                .frame(width: 124,height: 20)
            
            HStack{
                Image("navBack")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .asButton(.press) {
                        router.dismissScreen()
                    }
                Spacer()
//                Image("NotificationBellIcon")
//                    .frame(width: 25,height: 25)
            }
            .padding(.horizontal,24)
        }
    }
}

#Preview {
    BGVTimeSlotScreenView()
}
