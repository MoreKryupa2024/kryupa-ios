//
//  ContentView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 15/05/24.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    @State var showScreen : Int = Int()
    
    var body: some View {
        RouterView() { _ in
            switch showScreen {
            case 1: IntroductionScreenView()
            case 2: LobbyScreenView()
            case 3: CareGiverHomeScreenView()//Giver Tab View Controller
            case 4: CareSeekerHomeScreenView()//seeker Tab View Controller
            case 5: PaymentListView(selectedPaymentMethod: 0)
            default:
                splashView
            }
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
        .task {
            delayText()
        }
        .onAppear {
            
            NotificationCenter.default.addObserver(forName: .setLobbyScreen, object: nil, queue: nil,
                                using: self.setCareGiverLobbyScreen)
            
            NotificationCenter.default.addObserver(forName: .setCareGiverHomeScreen, object: nil, queue: nil,
                                using: self.setCareGiverHomeScreen)
            
            NotificationCenter.default.addObserver(forName: .setCareSeekerHomeScreen, object: nil, queue: nil,
                                using: self.setCareSeekerHomeScreen)
        }
    }
    
    func setCareGiverLobbyScreen(_ notification: Notification) {
        showScreen = 2
    }
    
    func setCareGiverHomeScreen(_ notification: Notification) {
        showScreen = 3
    }
    
    func setCareSeekerHomeScreen(_ notification: Notification) {
        showScreen = 4
    }
    
    private func delayText() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showScreen = 3
        }
    }
}

#Preview {
    ContentView()
}
