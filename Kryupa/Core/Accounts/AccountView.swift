//
//  AccountView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI
import SwiftfulUI

struct AccountView: View {
    
    @StateObject private var viewModel = AccountsViewModel()

    @State var arrAccountList: [AccountListData] = {
        if Defaults().userType == AppConstants.GiveCare{
            return AppConstants.giverAccountSectionItems
        }else{
            return AppConstants.seekerAccountSectionItems
        }
    }()
    
    @Environment(\.router) var router

    var body: some View {
        
        ScrollView(showsIndicators: false){
            HeaderTopView
            LazyVStack(alignment:.leading, spacing: 20) {
                ForEach(Array(arrAccountList.enumerated()), id: \.offset) { index, model in
                    getAccountCellView(model: model, index: index)
                        .asButton(.press) {
                            navigationLink(screen: model.title)
                        }
                    if Defaults().userType == AppConstants.GiveCare{
                        if index == 4 || index == 6 {
                            line
                        }
                    }else{
                        if index == 3 || index == 5 {
                            line
                        }
                    }
                    
                }
            }
            .padding(.top, 20)
        }
        .overlay(alignment: .top) {
                Color.clear
                    .background(.regularMaterial)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 0)
            }
        .onAppear() {
            UIScrollView.appearance().bounces = false
            viewModel.getProfile()
        }
    }

    private func navigationLink(screen:String){
        switch screen{
        case "Personal Details":
            router.showScreen(.push) { rout in
                if Defaults().userType == AppConstants.GiveCare{
//                    PersonalDetailView()
                    ProfileDetailScreenView(selecedProfile: viewModel.profile?.customerName ?? "")

                }else{
                    ProfileDetailScreenView(selecedProfile: viewModel.profile?.customerName ?? "")
                }
            }
            
        case "My Services": break
            
        case "Payments & Refunds","Payments":
            router.showScreen(.push) { rout in
                PaymentListView(selectedPaymentMethod: 0)
            }
            
        case "Reviews":
            router.showScreen(.push) { rout in
                ReviewsListView()
            }
        case "Help & FAQ":
            router.showScreen(.push) { rout in
                FAQView()
            }
        case "Settings":
            router.showScreen(.push) { rout in
                SettingsView()
            }
        case "About app":
            break
        case "Logout":
            break
           
        default:
            break
        }
        
    }
    
    private var line: some View {
        Divider()
            .background(.F_2_F_2_F_7)
            .padding(.trailing, 30)
            .padding(.leading, 0)
            .padding(.vertical, 15)
            .frame(height: 2)
    }
    
    private func getAccountCellView(model: AccountListData, index: Int)-> some View{
        
        HStack{
            Image(model.image)
            
            Text(model.title)
                .font(.custom(FontContent.plusRegular, size: 13))
                .foregroundStyle(.appMain)
        }
        .padding(.horizontal, 24)
    }
    
    private var HeaderTopView: some View {
        VStack {
            HeaderView(showBackButton: false)
            HStack{
                HStack {
                    Image("personal")
                        .resizable()
                        .frame(width: 68, height: 68)
                        .cornerRadius(34)
                }
                .frame(width: 74, height: 74)
                .overlay(
                    RoundedRectangle(cornerRadius: 37)
                        .inset(by: 1)
                        .stroke(.AEAEB_2, lineWidth: 1)
                )
                
                Text(viewModel.profile?.customerName ?? "")
                    .font(.custom(FontContent.besMedium, size: 20))
                    .foregroundStyle(.appMain)

                Spacer()
            }
            .frame(height: 74)
            .padding(.vertical, 20)
            .padding(.horizontal, 24)
            Spacer()
        }
        .background(.F_2_F_2_F_7)
        .clipShape(
            .rect (
                bottomLeadingRadius: 20,
                bottomTrailingRadius: 20
            )
        )
        
    }
}

struct AccountListData {
    let title: String
    let image: String
}

#Preview {
    AccountView()
}
