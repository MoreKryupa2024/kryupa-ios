//
//  BookingFormScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 31/05/24.
//

import Foundation

@MainActor
class BookingFormScreenViewModel: ObservableObject{
    @Published var showDatePicker: Bool = Bool()
    var dateState: Int = Int()
    
    var dateValue: Date = Date()
    var startDate: String = "".convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
    var endDate: String = "".convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
    
    var startTime: String = "".convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "HH:mm:ss")
    var endTime: String = "".convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "HH:mm:ss")
    
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
            DispatchQueue.main.async {
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
    }
    
    
    func createBooking(action:(@escaping(String)->Void)){
        let param: [String: Any] = [
            "profile_id":bookingForList.filter{$0.name == bookingFor}.first?.id ?? "",
            "area_of_expertise":needServiceInSelected,
            "booking_type":segSelected,
            "start_date":segSelected == "One Time" ? selectedDay.serverDate : startDate,
            "end_date":endDate,
            "start_time":startTime,
            "end_time":endTime,
            "gender":genderSelected,
            "language":languageSpeakingSelected,
            "years_of_exprience":[yearsOfExperienceSelected],
            "additional_skills":additionalInfoSelected,
            "additional_info":additionalInfoSelected
        ]
        print(param)
        isloading = true
        NetworkManager.shared.createBooking(params:param) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    print(data)
                    self?.isloading = false
                    action(data.data.id)
                case .failure(let error):
                    print(error)
                    self?.isloading = false
                }
            }
        }
    }
}
