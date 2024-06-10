//
//  BookingFormScreenViewModel.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 31/05/24.
//

import Foundation

class BookingFormScreenViewModel: ObservableObject{
    
    var selectedDay: WeakDayData = Date.getDates(forLastNDays: 1).first!
    @Published var bookingFor: String = String()
    @Published var segSelected: String = "One Time"
    @Published var bookingForList: [RelativeDataModel] = [RelativeDataModel]()
    
    @Published var genderSelected: String = String()
    @Published var languageSpeakingSelected: [String] = [String]()
    @Published var needServiceInSelected: [String] = [String]()
    @Published var additionalInfoSelected: [String] = [String]()
    @Published var additionalSkillsSelected: [String] = [String]()
    @Published var yearsOfExperienceSelected: String = String()
    @Published var isloading: Bool = Bool()
    
    
    func getBookingForRelativeList(){
        isloading = true
        NetworkManager.shared.getRelativeList { [weak self] result in
            switch result{
            case .success(let data):
                self?.isloading = false
                self?.bookingForList = data.data
            case .failure(let error):
                print(error)
                self?.isloading = false
            }
        }
    }
    
    
    func createBooking(){
        let param: [String: Any] = [
            "profile_id":bookingForList.filter{$0.name == bookingFor}.first?.id ?? "",
            "area_of_expertise":needServiceInSelected,
            "booking_type":"One Time",
            "start_date":"2024-05-20T06:00:00.000Z",
            "end_date":"2024-05-20T18:00:00.000Z",
            "start_time":"06:00:00",
            "end_time":"18:00:00",
            "gender":genderSelected,
            "language":languageSpeakingSelected,
            "years_of_exprience":yearsOfExperienceSelected,
            "additional_skills":additionalInfoSelected,
            "additional_info":additionalInfoSelected
        ]
    }
}
