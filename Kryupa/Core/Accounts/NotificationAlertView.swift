//
//  NotificationAlertView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI

struct NotificationAlertView: View {
    @State var state = true
    @State var arrNotificationAlert: [NotificationAlertData] = [
        NotificationAlertData(title: "Get notified about our latest updates:", toggleState: true),
        NotificationAlertData(title: "Get SMS alerts:", toggleState: true),
        NotificationAlertData(title: "Subscribe to our newsletter:", toggleState: true),
        NotificationAlertData(title: "WhatsApp notification:", toggleState: true)
    ]

    var body: some View {
        VStack {
            HeaderView
            LazyVStack(spacing: 15) {
                ForEach(Array(arrNotificationAlert.enumerated()), id: \.offset) { index, model in

                    getNotificationCellView(title: model.title, toggleState: model.toggleState,index: index)
                    line
                }
            }
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
            Text("Notification Alert")
                .font(.custom(FontContent.besMedium, size: 20))
                .foregroundStyle(.appMain)
        }
        
    }
    
    private func getNotificationCellView(title: String, toggleState: Bool, index: Int)-> some View{
        
        HStack{
            Text(title)
                .font(.custom(FontContent.plusRegular, size: 15))
                .foregroundStyle(._444446)
            Spacer()
            Group {
                    if toggleState {
                        Image("SwitchON")
                    } else {
                        Image("switchOff")
                    }
                }
                .onTapGesture {
                    
                    let newData = NotificationAlertData(title: title, toggleState: state)
                    arrNotificationAlert.remove(at: index)
                    arrNotificationAlert.insert(newData, at: index)
                    state.toggle()
                }
        }
        .padding(.horizontal, 24)
    }
        
        
        private var line: some View {
            Divider()
                .background(.F_2_F_2_F_7)
                .padding(.trailing, 30)
                .padding(.leading, 0)
                .padding(.vertical, 15)
                .frame(height: 2)
        }
    }

struct NotificationAlertData {
    let title: String
    let toggleState: Bool
}


#Preview {
    NotificationAlertView()
}
