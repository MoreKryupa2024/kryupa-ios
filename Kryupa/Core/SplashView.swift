//
//  ContentView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 15/05/24.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    @State var showScreen : Int = 0//Defaults().showScreen
    var setLobbyScreen = NotificationCenter.default
    var setCareGiverHomeScreen = NotificationCenter.default
    var setCareSeekerHomeScreen = NotificationCenter.default
    var logout = NotificationCenter.default
    
    var body: some View {
        RouterView() { _ in
            switch showScreen {
            case 1: IntroductionScreenView()
            case 2: LobbyScreenView()
            case 3: GiverTabbarScreenView()//Giver Tab View Controller
            case 4: ConsumerTabBarScreenView()//seeker Tab View Controller
            case 5: PersonalInformationSeekerView()
            case 6: PersonalInformationScreenView()
            case 7: MobileNumberScreenView()
            case 8: SelectProfileImageView()
            default:
                splashView
            }
        }
        .task {
            delayText()
            
            setLobbyScreen.addObserver(forName: .setLobbyScreen, object: nil, queue: nil,
                                using: self.setCareGiverLobbyScreen)
            
            setCareGiverHomeScreen.addObserver(forName: .setCareGiverHomeScreen, object: nil, queue: nil,
                                using: self.setCareGiverHomeScreen)
            
            setCareSeekerHomeScreen.addObserver(forName: .setCareSeekerHomeScreen, object: nil, queue: nil,
                                using: self.setCareSeekerHomeScreen)
            
            logout.addObserver(forName: .logout, object: nil, queue: nil,
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
        showScreen = 1
        Defaults().showScreen = 0
    }
    
    private func delayText() {
        showScreen = 0
        getUserStatus()
    }
    
    func getUserStatus(){
        if Defaults().accessToken != ""{
            NetworkManager.shared.getUserStatus { result in
                switch result{
                case .success(let data):
                    if data.data.role == AppConstants.SeekCare{
                        switch data.data.status{
//                        case "Personal information":
//                            showScreen = 5
//                            Defaults().showScreen = 5
//                            
//                        case "Take photo":
//                            showScreen = 8
//                            Defaults().showScreen = 8
                            
                        case "Onboarding done":
                            showScreen = 4
                            Defaults().showScreen = 4
                        default:
                            showScreen = 1
                            Defaults().showScreen = 1
                        }
                        
                    }else{
                        switch data.data.status{
//                        case "Mobile Verification":
//                            showScreen = 7
//                            Defaults().showScreen = 7
//                            
//                        case "Personal information":
//                            showScreen = 6
//                            Defaults().showScreen = 6
//                            
//                        case "Take photo":
//                            showScreen = 8
//                            Defaults().showScreen = 8
                            
                        case "Waitting at lobby":
                            showScreen = 2
                            Defaults().showScreen = 2
                            
                        case "Onboarding done":
                            showScreen = 3
                            Defaults().showScreen = 3
                        default:
                            showScreen = 1
                            Defaults().showScreen = 1
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        showScreen = Defaults().showScreen == 0 ? 1 : Defaults().showScreen
                    }
                }
            }
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                showScreen = Defaults().showScreen == 0 ? 1 : Defaults().showScreen
            }
        }
    }
}

#Preview {
    ContentView()
}
