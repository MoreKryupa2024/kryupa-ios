//
//  DeactivateAccountView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI
import SwiftfulUI

struct DeactivateAccountView: View {
    
    @StateObject var viewModel = SettingViewModel()
    @Environment(\.router) var router
    
    var body: some View {
        ZStack{
            VStack {
                HeaderView(title: "Deactivate / Delete account",showBackButton: true)
                DeleteView
                Spacer()
            }
            .toolbar(.hidden, for: .navigationBar)
            
            if viewModel.isloading{
                LoadingView()
            }
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
                    viewModel.selectedOption = title
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
                
                ForEach(Array(viewModel.arrcheckList.enumerated()), id: \.offset) { index, model in
                    getCheckboxCell(title: model.title, toggleState: viewModel.selectedOption == model.title,index: index)
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
                    viewModel.deleteAccount()
                    router.dismissScreenStack()
                }
                .padding(.top, 20)
            
        }

    }
}

#Preview {
    DeactivateAccountView()
}
