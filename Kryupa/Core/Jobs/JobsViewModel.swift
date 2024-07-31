//
//  JobsViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 27/06/24.
//

import Foundation

class JobsViewModel: ObservableObject {
    @Published var isloading: Bool = Bool()
    @Published var isComingfromChat: Bool = false
    @Published var jobDetailModel: JobDetailData?
    @Published var startDate = String()
    @Published var otherDiseaseType = String()
    @Published var jobPost = [JobPost]()

    func getJobsDetail(approachID: String, completion: @escaping (()->Void)){
        
        isloading = true
        NetworkManager.shared.getJobsDetails(approachID: approachID) { [weak self] result in
            DispatchQueue.main.async() {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.jobDetailModel = data.data
                    self?.startDate = self?.jobDetailModel?.startDate.components(separatedBy: "T").first ?? ""
                    self?.otherDiseaseType = self?.jobDetailModel?.otherDiseaseType == "" ? "-" : self?.jobDetailModel?.otherDiseaseType ?? ""
                    completion()
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
        }
    }
    
    func getJobsList(){
        let param = ["pageNumber":1,
                     "pageSize":20]
        
        isloading = true
        NetworkManager.shared.getJobList(params: param) { [weak self] result in
            DispatchQueue.main.async() {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.jobPost = data.data.jobPost
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
