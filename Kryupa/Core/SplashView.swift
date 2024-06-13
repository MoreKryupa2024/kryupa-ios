//
//  ContentView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 15/05/24.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    @State var showScreen : Int = Defaults().showScreen
    
    var body: some View {
        RouterView() { _ in
            switch showScreen {
            case 1: IntroductionScreenView()
            case 2: LobbyScreenView()
            case 3: CareGiverHomeScreenView()//Giver Tab View Controller
            case 4: ConsumerTabBarScreenView()//seeker Tab View Controller
            case 5: PaymentListView(selectedPaymentMethod: 0)
            case 6: SettingsView()
            default:
                splashView
            }
        }
        .onAppear {
            delayText()
            
            NotificationCenter.default.addObserver(forName: .setLobbyScreen, object: nil, queue: nil,
                                using: self.setCareGiverLobbyScreen)
            
            NotificationCenter.default.addObserver(forName: .setCareGiverHomeScreen, object: nil, queue: nil,
                                using: self.setCareGiverHomeScreen)
            
            NotificationCenter.default.addObserver(forName: .setCareSeekerHomeScreen, object: nil, queue: nil,
                                using: self.setCareSeekerHomeScreen)
            
            NotificationCenter.default.addObserver(forName: .logout, object: nil, queue: nil,
                                using: self.logout)
        }
    }
    
    private var splashView:some View{
        ZStack{
            
            VStack{
                Image("splashLogo")
                    .resizable()
                    .frame(width: 123,height: 54)
                Spacer()
            }
            
            VStack(spacing:30){
                Image("mainLogo")
                    .resizable()
                    .frame(width: 166,height: 171)
                
                Text("Caring Hands, One Tap Away.")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(._444446)
            }
        }
    }
    
    private func setCareGiverLobbyScreen(_ notification: Notification) {
        showScreen = 2
        Defaults().showScreen = 2
    }
    
    private func setCareGiverHomeScreen(_ notification: Notification) {
        showScreen = 3
        Defaults().showScreen = 3
    }
    
    private func setCareSeekerHomeScreen(_ notification: Notification) {
        showScreen = 4
        Defaults().showScreen = 4
    }
    
    private func logout(_ notification: Notification) {
        Defaults().showScreen = 1
        delayText()
    }
    
    private func delayText() {
        showScreen = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showScreen = Defaults().showScreen == 0 ? 1 : Defaults().showScreen
        }
    }
}

#Preview {
    ContentView()
}
