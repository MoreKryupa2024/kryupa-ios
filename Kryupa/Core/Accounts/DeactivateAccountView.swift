//
//  DeactivateAccountView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI

struct DeactivateAccountView: View {
    
    @State var state = true
    @State var arrcheckList: [NotificationAlertData] = [
        NotificationAlertData(title: "Yes, I am sure", toggleState: false),
        NotificationAlertData(title: "No, Deactivate my account till next login", toggleState: false)
    ]

    var body: some View {
        VStack {
            HeaderView
            DeleteView
            Spacer()
        }
    }
    
    private func getCheckboxCell(title: String, toggleState: Bool, index: Int)-> some View{
        
        HStack{
            Group {
                    if toggleState {
                        Image("checkboxSelected")
                    } else {
                        Image("checkboxUnselected")
                    }
                }
                .onTapGesture {
                    let newData = NotificationAlertData(title: title, toggleState: state)
                    arrcheckList.remove(at: index)
                    arrcheckList.insert(newData, at: index)
                    state.toggle()
                }
                        
            Text(title)
                .font(.custom(FontContent.plusRegular, size: 12))
                .foregroundStyle(._444446)
            
            Spacer()
        }
    }
    
    private var DeleteView: some View{
        
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                Text("Are you sure you want to delete the account?")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(._444446)
                
                ForEach(Array(arrcheckList.enumerated()), id: \.offset) { index, model in
                    getCheckboxCell(title: model.title, toggleState: model.toggleState,index: index)
                }
                
            }
            .padding(.horizontal, 25)
            .padding(.top, 10)
            
            Text("Delete Account")
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(.white)
                .frame(height: 53)
                .frame(width: 195)
                .background{
                    RoundedRectangle(cornerRadius: 48)
                }
                .asButton(.press) {
                    
                }
                .padding(.top, 20)
            
        }

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
            Text("Deactivate / Delete account")
                .font(.custom(FontContent.besMedium, size: 20))
                .foregroundStyle(.appMain)
        }
        
    }
}

#Preview {
    DeactivateAccountView()
}
