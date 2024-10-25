//
//  StartServiceScreenView.swift
//  Kryupa
//
//  Created by user on 22/10/24.
//

import SwiftUI
import SwiftfulUI

struct StartServiceScreenView: View {
    
    @State private var isSelectedView = 0
    var serviceStartData: [ServiceStartData] = []
    
    var confromAction: ((ServiceStartData)->Void)? = nil
    var cancelAction: ((ServiceStartData)->Void)? = nil
    
    var body: some View {
        ZStack{
            VStack(spacing:15){
                HeaderView()
                ScrollView{
                    VStack(spacing:0){
                        Text("Click the button to start service for ")
                            .multilineTextAlignment(.center)
                            .frame(width: 250)
                            .font(.custom(FontContent.plusRegular, size: 22))
                            .padding(.top,30)
                        
                        VStack(spacing: 0){
                            TabView(selection:$isSelectedView){
                                ForEach(serviceStartData.indices, id: \.self) { index in
                                    VStack(spacing:0){
                                        Text(Defaults().userType == AppConstants.SeekCare ? serviceStartData[index].customerName : serviceStartData[index].caregiverName)
                                            .font(.custom(FontContent.besMedium, size: 28))
                                            .padding(.top,15)
                                            .padding(.bottom,20)
                                        
                                        
                                        HStack {
                                            ImageLoadingView(imageURL: serviceStartData[index].profilePictureUrl)
                                                .frame(width: 160, height: 160)
                                                .cornerRadius(80)
                                                .clipped()
                                        }
                                        .frame(width: 170, height: 170)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 85)
                                                .inset(by: 1)
                                                .stroke(.AEAEB_2, lineWidth: 1)
                                        )
                                        .padding(.vertical,20)
                                        
                                        Text(Defaults().userType != AppConstants.SeekCare ? serviceStartData[index].customerName : serviceStartData[index].caregiverName)
                                            .font(.custom(FontContent.besMedium, size: 17))
                                            .padding(.bottom,5)
                                        Text(serviceStartData[index].areaOfExperties)
                                            .font(.custom(FontContent.plusMedium, size: 15))
                                            .foregroundStyle(._018_ABE)
                                            .padding(.bottom,20)
                                    }
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(height: 350)
                            
                            if serviceStartData.count > 1{
                                HStack{
                                    ForEach(serviceStartData.indices, id: \.self) { index in
                                        Circle()
                                            .frame(height: 6)
                                            .foregroundStyle(isSelectedView != index.id ? .D_1_D_1_D_6 : .appMain)
                                    }
                                }
                            }
                            
                            VStack(spacing:15){
                                
                                Text("Start Service")
                                    .font(.custom(FontContent.plusRegular, size: 16))
                                    .foregroundStyle(.white)
                                    .frame(height: 53)
                                    .frame(width: 191)
                                    .background{
                                        RoundedRectangle(cornerRadius: 48)
                                    }
                                    .asButton(.press) {
                                        confromAction?(serviceStartData[isSelectedView])
                                    }
                                
                                Text("Cancel Service")
                                    .font(.custom(FontContent.plusRegular, size: 16))
                                    .foregroundStyle(.appMain)
                                    .frame(height: 53)
                                    .frame(width: 191)
                                    .asButton(.press) {
                                        cancelAction?(serviceStartData[isSelectedView])
                                    }
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 48)
                                            .inset(by: 1)
                                            .stroke(.appMain, lineWidth: 1)
                                    )
                            }
                            .padding(.top,40)
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}

#Preview {
    StartServiceScreenView()
}
