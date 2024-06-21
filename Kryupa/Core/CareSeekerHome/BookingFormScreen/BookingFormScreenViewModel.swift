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
    
    var startDateValue: Date = Date()
    var startTimeValue: Date = Date()
    var startDate: String = "".convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
    var endDate: String = "".convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
    
    var startTime: String = "".convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "HH:mm:ss")
    var endTime: String = "".convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "HH:mm:ss")
    
    var selectedDay: WeakDayData = Date.getDates(forLastNDays: 1).first!
    @Published var bookingFor: String = String()
    @Published var segSelected: String = "One Time"
    @Published var bookingForList: [RelativeDataModel] = [RelativeDataModel]()
    
    @Published var genderSelected: String = String()
    
    var bookingID: String = Defaults().bookingId
    @Published var bookingIDData: BookingIDData?
    
    @Published var languageSpeakingSelected: [String] = [String]()
    @Published var needServiceInSelected: [String] = [String]()
    @Published var additionalInfoSelected: [String] = [String]()
    @Published var additionalSkillsSelected: [String] = [String]()
    @Published var yearsOfExperienceSelected: String = String()
    @Published var isloading: Bool = Bool()
    
    func setPrefieldBookingData(){
        guard let bookingIDData else {
            return
        }
        bookingFor = bookingForList.filter{$0.id == bookingIDData.profileID}.first?.name ?? ""
        
        let weakDay = WeakDayData(id: 0,
                                  day:  bookingIDData.startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "E"),
                                  numDay: bookingIDData.startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "dd"),
                                  serverDate: bookingIDData.startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),
                                  serverTime: bookingIDData.startTime)
        
        
        selectedDay = Date.getDates(forLastNDays: 7).filter{$0.day == weakDay.day && $0.numDay == weakDay.numDay}.first ?? Date.getDates(forLastNDays: 1).first!
        startDate = bookingIDData.startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        endDate = bookingIDData.endDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
        
        startTime = bookingIDData.startTime
        endTime = bookingIDData.endTime
        
        segSelected = bookingIDData.bookingType
        additionalSkillsSelected = bookingIDData.additionalSkills
//        additionalInfoSelected = bookingIDData.add
        genderSelected = bookingIDData.gender
        yearsOfExperienceSelected = bookingIDData.yearsOfExprience
        languageSpeakingSelected = bookingIDData.languages
        needServiceInSelected = bookingIDData.areasOfExpertise
    }
    
    
    func getBookingForRelativeList(){
        isloading = true
        NetworkManager.shared.getRelativeList { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.bookingForList = data.data
                    if (self?.bookingID != "") {
                        self?.getBookingDetailsById()
                    }
                case .failure(let error):
                    print(error)
                    self?.isloading = false
                }
            }
        }
    }
    
    func getBookingDetailsById(){
        isloading = true
        NetworkManager.shared.getBookingDetailsById(bookingId: bookingID) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.bookingIDData = data.data
                    self?.setPrefieldBookingData()
                case .failure(let error):
                    print(error)
                    self?.isloading = false
                }
            }
        }
    }
    
    
    func createBooking(action:(@escaping(String)->Void)){
        let param: [String: Any] = [
            "booking_id":bookingID,
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
            "additional_skills":additionalSkillsSelected,
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
