//
//  AccountView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI

struct AccountView: View {
    @State var arrAccountList: [AccountListData] = [
        AccountListData(title: "Personal Details", image: "personalDetail"),
        AccountListData(title: "My Services", image: "myservice"),
        AccountListData(title: "Payments", image: "payments"),
        AccountListData(title: "Reviews", image: "reviews"),
        AccountListData(title: "Help & FAQ", image: "help"),
        AccountListData(title: "Settings", image: "settings"),
        AccountListData(title: "About app", image: "aboutUs"),
        AccountListData(title: "Logout", image: "logout")
    ]

    var body: some View {
        
        ScrollView(showsIndicators: false){
            HeaderTopView
            LazyVStack(alignment:.leading, spacing: 20) {
                ForEach(Array(arrAccountList.enumerated()), id: \.offset) { index, model in
                    getAccountCellView(model: model, index: index)
                    if index == 4 || index == 6 {
                        line
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
                
                Text("John Smith")
                    .font(.custom(FontContent.besMedium, size: 20))
                    .foregroundStyle(.appMain)

                Spacer()
            }
            .frame(height: 74)
            .padding(.vertical, 20)
            
            Spacer()
        }
        .padding(.horizontal, 24)
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
