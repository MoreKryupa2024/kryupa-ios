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
    
    @Published var recommendedCaregiver: [RecommendedCaregiverData] = [RecommendedCaregiverData]()
    @Published var upcommingAppointments: [AppointmentData] = [AppointmentData]()
    @Published var pastAppointments: [AppointmentData] = [AppointmentData]()
    
    func getRecommandationList(){
        
        let param = [
            "pageNumber":1,
            "pageSize":10
        ]
        isloading = true
        NetworkManager.shared.getRecommandationList(params: param) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.recommendedCaregiver = data.data.recommendedCaregiver
                    self?.upcommingAppointments = data.data.upcommingAppointments
                    self?.pastAppointments = data.data.pastAppointments
                case .failure(let error):
                    self?.isloading = false
                    print(error)
                }
            }
        }
    }
    
}
