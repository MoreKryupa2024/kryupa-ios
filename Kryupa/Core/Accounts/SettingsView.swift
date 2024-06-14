//
//  SettingsView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI
import SwiftfulUI

struct SettingsView: View {
    
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            HeaderView(title: "Settings",showBackButton: true)
            getSettingsCellView(imgName: "setting_notification", title: "Notifications & Alert", withLine: true)
                .asButton(.press) {
                    router.showScreen(.push) { rout in
                        NotificationAlertView()
                    }
                }
            getSettingsCellView(imgName: "setting_delete_account", title: "Delete or deactivate account", withLine: true)
                .asButton(.press) {
                    router.showScreen(.push) { rout in
                        DeactivateAccountView()
                    }
                }
            getSettingsCellView(imgName: "setting_language", title: "Language", withLine: false)
                .asButton(.press) {
//                    router.showScreen(.push) { rout in
//                        <#code#>
//                    }
                }
            Spacer()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var line: some View {
        Divider()
            .background(.F_2_F_2_F_7)
            .padding(.trailing, 30)
            .padding(.leading, 0)
            .padding(.vertical, 10)
    }
    
    private func getSettingsCellView(imgName: String, title: String, withLine: Bool)-> some View{
        VStack {
            HStack {
                HStack(spacing: 16) {
                    Image(imgName)
                        .resizable()
                        .frame(width: 35, height: 35)
                    Text(title)
                        .font(.custom(FontContent.plusRegular, size: 14))
                        .foregroundStyle(.appMain)
                    Spacer()
                }
            }
            .padding(.horizontal, 24)
            
            if withLine {
                line
            }
            
        }
    }
}

#Preview {
    SettingsView()
}
