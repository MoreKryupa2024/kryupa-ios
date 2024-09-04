//
//  CareGiverHomeScreenViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 12/06/24.
//

import Foundation
import Combine

@MainActor
class CareGiverHomeScreenViewModel: ObservableObject
{
    @Published var jobsNearYou: [JobPost] = [JobPost]()
    @Published var isloading: Bool = Bool()
    @Published var jobAcceptModel: [JobAcceptData] = [JobAcceptData]()
    @Published var serviceStartData: ServiceStartData?
    @Published var pagination: Bool = true
    @Published var pageNumber = 1
    @Published var topBanner: [BannerDataModel] = [BannerDataModel]()
    @Published var bottomBanner: [BannerDataModel] = [BannerDataModel]()
    
    
    func getBannerBottomData(screenName: String){
        let param = [
            "screen_name": screenName
        ]
        NetworkManager.shared.getBannerUrls(params: param) { [weak self] result in
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    print("")
                case .failure(let error):
                    print(error)
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

    func getJobsNearYouList(completion: @escaping (()->Void)){
        
        let param = [
            "pageNumber":1,
            //"pageNumber":pageNumber,
            "pageSize":20
        ]
        isloading = true
        NetworkManager.shared.getJobsNearYouList(params: param) { [weak self] result in
            
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.jobsNearYou = data.data.jobPost
                    completion()
                    /*  if self!.pageNumber > 1{
                     self?.jobsNearYou += data.data.jobPost
                 }else{
                     self?.jobsNearYou = data.data.jobPost
                 }
                 self?.pagination = data.data.jobPost.count != 0*/
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
    func giverConfirmStartService(){
        guard let approch_id = serviceStartData?.id else {return}
        let param = [
            "approch_id": approch_id
        ]
        isloading = true
        NetworkManager.shared.giverConfirmStartService(params: param) { [weak self] result in
            DispatchQueue.main.async() {
                self?.isloading = false
                switch result{
                case .success(_):
                    self?.serviceStartData = nil
                case .failure(let error):
                    print(error)
                }
            }
            
        }
    }
    
    func acceptRejectJob(approchID: String, status: String, completion: @escaping (()->Void)){
        let param = [
            "approch_id": approchID,
            "status":status
        ]
        isloading = true
        NetworkManager.shared.updateApprochStatus(params: param) { [weak self] result in
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.jobAcceptModel = data.data
                    completion()
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                    completion()
                }
            }
            
        }
    }
    
    func caregiverSvcAct(){
        isloading = true
        NetworkManager.shared.caregiverSvcAct() { [weak self] result in
            DispatchQueue.main.async {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.serviceStartData = data.dataTwo
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
