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
    @Published var upcommingAppointments: [AppointmentData] = [AppointmentData]()
    @Published var pastAppointments: [AppointmentData] = [AppointmentData]()
    @Published var serviceStartData: ServiceStartData?
    
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
                }
            }
        }
    }
    
    func customerSvcAct(){
        isloading = true
        NetworkManager.shared.customerSvcAct() { [weak self] result in
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
    
    func customerConfirmStartService(){
        guard let approch_id = serviceStartData?.id else {return}
        let param = [
            "approch_id": approch_id
        ]
        isloading = true
        NetworkManager.shared.customerConfirmStartService(params: param) { [weak self] result in
            DispatchQueue.main.async() {
                self?.isloading = false
                switch result{
                case .success(_):
                    self?.serviceStartData = nil
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
            
        }
    }
    
}
