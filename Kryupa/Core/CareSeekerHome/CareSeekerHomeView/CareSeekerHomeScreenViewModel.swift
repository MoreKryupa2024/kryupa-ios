//
//  CareSeekerHomeScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 04/06/24.
//

import Foundation

@MainActor
class CareSeekerHomeScreenViewModel: ObservableObject{
    @Published var isloading: Bool = Bool()
    @Published var pagination: Bool = true
    @Published var pageNumber = 1
    @Published var recommendedCaregiver: [RecommendedCaregiverData] = [RecommendedCaregiverData]()
    @Published var upcommingAppointments: [BookingsListData] = [BookingsListData]()
    @Published var pastAppointments: [BookingsListData] = [BookingsListData]()
    @Published var topBanner: [BannerDataModel] = [BannerDataModel]()
    @Published var bottomBanner: [BannerDataModel] = [BannerDataModel]()
    
    @Published var serviceStartData: [ServiceStartData] = []
    
    func getRecommandationList(){
        
        let param = [
            //"pageNumber":pageNumber,
            "pageNumber":1,
            "pageSize":20
        ]
        isloading = true
        NetworkManager.shared.getRecommandationList(params: param) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.recommendedCaregiver = data.data.recommendedCaregiver.sorted(by: { $0.rating > $1.rating })
                    self?.upcommingAppointments = data.data.upcommingAppointments
                    self?.pastAppointments = data.data.pastAppointments
                    self?.customerSvcAct()
                    /* if self!.pageNumber > 1{
                     self?.recommendedCaregiver += data.data.recommendedCaregiver.sorted(by: { $0.rating > $1.rating })
                     self?.upcommingAppointments += data.data.upcommingAppointments
                     self?.pastAppointments += data.data.pastAppointments
                 }else{
                     self?.recommendedCaregiver = data.data.recommendedCaregiver.sorted(by: { $0.rating > $1.rating })
                     self?.upcommingAppointments = data.data.upcommingAppointments
                     self?.pastAppointments = data.data.pastAppointments
                 }
                 self?.pagination = data.data.recommendedCaregiver.count != 0*/
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                    self?.customerSvcAct()
                }
            }
        }
    }
    
    func customerSvcAct(){
//        isloading = true
        NetworkManager.shared.customerSvcAct() { [weak self] result in
            DispatchQueue.main.async {
//                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.serviceStartData = data.data
                    self?.getBannerTopData(screenName: AppConstants.CUSTOMERHOMETOPScreenBanner)
                case .failure(let error):
                    print(error)
                    self?.serviceStartData = []
                    self?.getBannerTopData(screenName: AppConstants.CUSTOMERHOMETOPScreenBanner)
                }
            }
        }
    }
    
    func getBannerBottomData(screenName: String){
        let param = [
            "screen_name": screenName
        ]
        NetworkManager.shared.getBannerUrls(params: param) { [weak self] result in
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    print("")
//                    self?.getBannerTopData(screenName: AppConstants.CUSTOMERHOMEBOTTOMScreenBanner)
                case .failure(let error):
                    print("")
//                    self?.getBannerTopData(screenName: AppConstants.CUSTOMERHOMEBOTTOMScreenBanner)
                }
            }
        }
    }
    
    func getBannerTopData(screenName: String) {
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
    
    func customerConfirmStartService(serviceStartData:ServiceStartData){
        let approch_id = serviceStartData.id
        let param = [
            "approch_id": approch_id
        ]
        isloading = true
        NetworkManager.shared.customerConfirmStartService(params: param) { [weak self] result in
            DispatchQueue.main.async() {
                self?.isloading = false
                switch result{
                case .success(_):
                    self?.getRecommandationList()
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
}
