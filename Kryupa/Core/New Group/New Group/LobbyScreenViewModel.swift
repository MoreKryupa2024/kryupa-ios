//
//  LobbyScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 11/06/24.
//

import Foundation
@MainActor
class LobbyScreenViewModel: ObservableObject{
 
    @Published var isloading: Bool = Bool()
    @Published var slotTitle: String = "Schedule Your\nBGV Interview!"
    @Published var slotTime: String = "Complete Interview & begin\nyour caregiving services"
    @Published var slotButton: String = "Schedule Now"
    @Published var topBanner: [BannerDataModel] = [BannerDataModel]()
    var meetingTokenData: BGVInterviewMeetingTokenData?
    
    
    func getLobbyStatus(){
        isloading = true
        NetworkManager.shared.getLobbyStatus() { [weak self] result in
            DispatchQueue.main.async {
                self?.isloading = false
                switch result{
                case .success(let data):
                    if data.data.interviewStatus == "pending"{
                        self?.slotTitle = "Schedule Your\nBGV Interview!"
                        self?.slotButton = "Schedule Now"
                        self?.slotTime = "Complete Interview & begin\nyour caregiving services"
                    }else{
                        self?.slotTitle = "Your BGV Interview\nhas been scheduled!"
                        self?.slotButton = "Join Now"
                        self?.slotTime = "Meeting will begin in\n\(data.data.interviewDateTime)"
                    }
                case.failure(_):
                    self?.slotTitle = "Schedule Your\nBGV Interview!"
                    self?.slotButton = "Schedule Now"
                    self?.slotTime = "Complete Interview & begin\nyour caregiving services"
                }
            }
        }
    }
    
    func getBannerData(screenName: String){
        let param = [
            "screen_name": screenName
        ]
        NetworkManager.shared.getBannerUrls(params: param) { [weak self] result in
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.topBanner = data.data
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
    
    func getMeetingToken(alert:@escaping((String)->Void),next:@escaping(()->Void)){
        isloading = true
        NetworkManager.shared.getMeetingToken() { [weak self] result in
            DispatchQueue.main.async {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.meetingTokenData = data.data
                    next()
                case.failure(let error):
                    print(error)
                    alert(error.getMessage())
                }
            }
        }
    }
    
    func bookSlot(id: String){
        let param = ["slotId":id]
        NetworkManager.shared.bookSlot(params: param, completionHandler: { result in
            switch result{
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        })
    }

    
}
