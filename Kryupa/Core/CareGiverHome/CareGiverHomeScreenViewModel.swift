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

    func getJobsNearYouList(completion: @escaping (()->Void)){
        
        let param = [
            "pageNumber":1,
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
                    self?.serviceStartData = data.data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
