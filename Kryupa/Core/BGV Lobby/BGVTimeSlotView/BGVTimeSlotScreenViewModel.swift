//
//  BGVTimeSlotScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 30/05/24.
//

import Foundation
@MainActor
class BGVTimeSlotScreenViewModel: ObservableObject{
    var selectedDay: WeakDayData = Date.getDates(forLastNDays: 1).first!
    @Published var selectedSlotID: String = String()
    var availableSlotsList: [BGVInterviewSlotsListDataModel] = [BGVInterviewSlotsListDataModel]()
    @Published var isloading: Bool = Bool()
    
    func getSlotList(){
        isloading = true
        let param = ["date":selectedDay.serverDate]
        NetworkManager.shared.getSlotList(params: param) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case.failure(let error):
                    print(error)
                    self?.isloading = false
                case .success(let data):
                    self?.availableSlotsList = data.data
                    self?.isloading = false
                }
            }
        }
    }
}
