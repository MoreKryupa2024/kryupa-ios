//
//  SettingsView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            HeaderView
            getSettingsCellView(imgName: "setting_notification", title: "Notifications & Alert", withLine: true)
            getSettingsCellView(imgName: "setting_delete_account", title: "Delete or deactivate account", withLine: true)
            getSettingsCellView(imgName: "setting_language", title: "Language", withLine: false)
            Spacer()
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
            Text("Settings")
                .font(.custom(FontContent.besMedium, size: 20))
                .foregroundStyle(.appMain)
        }
        
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
