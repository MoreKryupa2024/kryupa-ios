//
//  NotificationAlertView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI

struct NotificationAlertView: View {
    
    @StateObject var viewModel = SettingViewModel()
    var body: some View {
        ZStack{
            VStack {
                HeaderView(title: "Notification Alert",showBackButton: true)
                LazyVStack(spacing: 15) {
                    ForEach(Array(viewModel.arrNotificationAlert.enumerated()), id: \.offset) { index, model in
                        
                        getNotificationCellView(title: model.title, toggleState: model.toggleState,index: index)
                        if index != viewModel.arrNotificationAlert.count - 1 {
                            line
                        }
                        
                    }
                }
                Spacer()
            }
            .toolbar(.hidden, for: .navigationBar)
            .onAppear{
                viewModel.getNotificationSetting()
            }
            
            if viewModel.isloading{
                LoadingView()
            }
        }
    }
    
    private func getNotificationCellView(title: String, toggleState: Bool, index: Int)-> some View{
        
        HStack{
            Text(title)
                .font(.custom(FontContent.plusRegular, size: 15))
                .foregroundStyle(._444446)
            Spacer()
            HStack {
                    if toggleState {
                        Image("SwitchON")
                    } else {
                        Image("switchOff")
                    }
                }
                .onTapGesture {
                    viewModel.arrNotificationAlert[index].toggleState = !viewModel.arrNotificationAlert[index].toggleState
                    viewModel.updateNotificationSetting()
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
    var title: String
    var toggleState: Bool
}

#Preview {
    NotificationAlertView()
}
