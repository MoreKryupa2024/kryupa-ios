//
//  MyServicesView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import SwiftUI
import SwiftfulUI

struct MyServicesView: View {
    
    @StateObject private var viewModel = MyServiceViewModel()

    var body: some View {
        
        ScrollView {
            HeaderView
            AreaOfExpertiseView
            line
            MySkillsView
            BottomButtonView
        }
    }
    
    private var BottomButtonView: some View{
                    
            HStack() {
                Text("Save")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 53)
                    .frame(width: 135)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        
                    }
                
                Spacer()
                
                Text("Cancel")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
                    .frame(height: 53)
                    .frame(width: 135)
                    .overlay(
                        RoundedRectangle(cornerRadius: 48)
                            .inset(by: 1)
                            .stroke(.appMain, lineWidth: 1)
                    )
                    .asButton(.press) {
                        
                    }
            }
            .padding([.top, .horizontal], 24)
    }
    
    private var MySkillsView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("My Skills")
            }
            .font(.custom(FontContent.plusRegular, size: 17))
            
            
            ZStack{
                NonLazyVGrid(columns: 2, alignment: .leading, spacing: 10, items: viewModel.mySkillsList) { service in
                    if let service{
                        CheckBoxView(
                            isSelected: !viewModel.mySkillsSelected.contains(service),
                            name: service
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            if viewModel.mySkillsSelected.contains(service){
                                viewModel.mySkillsSelected = viewModel.mySkillsSelected.filter{ $0 != service}
                            }else{
                                viewModel.mySkillsSelected.append(service)
                            }
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        .padding(.horizontal,24)
        .padding(.top, 10)
    }
    
    private var line: some View {
        Divider()
            .background(.F_2_F_2_F_7)
            .padding(.trailing, 30)
            .padding(.leading, 0)
            .padding(.top, 10)
    }
    
    
    private var AreaOfExpertiseView: some View{
        
        VStack(alignment: .leading){
            HStack(spacing:0){
                Text("Area of expertise")
                    .font(.custom(FontContent.plusRegular, size: 17))
                    .foregroundStyle(.appMain)
            }
            
            ZStack{
                NonLazyVGrid(columns: 1, alignment: .leading, spacing: 10, items: viewModel.areaOfExpertiseList) { service in
                    if let service{
                        CheckBoxView(
                            isSelected: !viewModel.areaOfExpertiseSelected.contains(service),
                            name: service
                        )
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .asButton(.press) {
                            if viewModel.areaOfExpertiseSelected.contains(service){
                                viewModel.areaOfExpertiseSelected = viewModel.areaOfExpertiseSelected.filter{ $0 != service}
                            }else{
                                viewModel.areaOfExpertiseSelected.append(service)
                            }
                        }
                    }else{
                        EmptyView()
                    }
                }
            }
        }
        .padding(.horizontal,24)
        .padding(.top,10)
    }
    
    private var HeaderView: some View{
        
        VStack(spacing: 24) {
            ZStack{
            Image("KryupaLobby")
                .resizable()
                .frame(width: 124,height: 20)
            
            HStack{
                Image("navBack")
                    .resizable()
                    .frame(width: 30,height: 30)
                    .asButton(.press) {
                    }
                Spacer()
                Image("NotificationBellIcon")
                    .frame(width: 25,height: 25)
            }
            .padding(.horizontal,24)
        }
        
        Text("My Services")
            .font(.custom(FontContent.besMedium, size: 20))
            .foregroundStyle(.appMain)
    }
        
    }
}

#Preview {
    MyServicesView()
}
