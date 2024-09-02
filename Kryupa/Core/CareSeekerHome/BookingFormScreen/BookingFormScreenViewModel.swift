//
//  BookingFormScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 31/05/24.
//

import Foundation

class BookingFormScreenViewModel: ObservableObject{
    @Published var showDatePicker: Bool = Bool()
    var dateState: Int = Int()
    
    @Published var startDateValue: Date = Date()
    @Published var endDateValue: Date = Date().addingTimeInterval(86400)
    @Published var startTimeValue: Date = Date()//.addingTimeInterval(14400)
    @Published var endTimeValue: Date = Date().addingTimeInterval(3600)//.addingTimeInterval(18000)
    @Published var startDate: String = "".convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
    @Published var endDate: String = "".convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ssZ", afterFormat: "yyyy-MM-dd'T'HH:mm:ssZ")
    @Published var startTime: String = dateFormatChange(dateFormat: "HH:mm:ss", dates: Date())//.addingTimeInterval(14400))
    @Published var endTime: String = dateFormatChange(dateFormat: "HH:mm:ss", dates: Date().addingTimeInterval(3600))//.addingTimeInterval(18000))
    
    @Published var selectedDay: WeakDayData = Date.getDates(forLastNDays: 1).first!
    @Published var bookingFor: String = String()
    @Published var giverName: String = String()
    @Published var giverId: String = String()
    @Published var segSelected: String = "One Time"
    @Published var bookingForList: [RelativeDataModel] = [RelativeDataModel]()
    
    @Published var genderSelected: String = String()
    
    var bookingID: String = Defaults().bookingId
    @Published var bookingIDData: BookingIDData?
    
    @Published var languageSpeakingSelected: [String] = ["English"]
    @Published var needServiceInSelected: [String] = [String]()
    @Published var additionalInfoSelected: [String] = [String]()
    @Published var additionalSkillsSelected: [String] = [String]()
    @Published var yearsOfExperienceSelected: String = "Any"
    @Published var isloading: Bool = Bool()
    @Published var isRecommended: Bool = false
    @Published var recommendedUserBookingData: RecommendedUserBookingData?
    
    init(){
        if startTime > "23:00:00" && segSelected == "One Time"{
            endTime = "23:59:00"
            guard let date = dateFormatChangeToDate(dateFormat: "HH:mm:ss", dates: "23:59:00") else { return }
            endTimeValue = date
        }else{
            endTime = dateFormatChange(dateFormat: "HH:mm:ss", dates: Date().addingTimeInterval(3600))//.addingTimeInterval(18000))
            endTimeValue = Date().addingTimeInterval(3600)
        }
    }
    
    func getCustomerRequirements(errorAlert: @escaping ((String)-> Void)){
        isloading = true
        NetworkManager.shared.getCustomerRequirements() { [weak self] result in
            DispatchQueue.main.async {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.recommendedUserBookingData = data.data.preference
                    self?.genderSelected = data.data.preference.gender
                    self?.yearsOfExperienceSelected = data.data.preference.yearOfExperience
                    self?.needServiceInSelected = data.data.preference.preferredServiceType
                    self?.languageSpeakingSelected = data.data.preference.preferredLang
                case .failure(let error):
                    errorAlert(error.getMessage())
                }
            }
        }
    }
    
    func setPrefieldBookingData(){
        guard let bookingIDData else {
            return
        }
        bookingFor = bookingForList.filter{$0.id == bookingIDData.profileID}.first?.name ?? ""
        if startDate < bookingIDData.startDate.convertDateFormater(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", afterFormat: "yyyy-MM-dd'T'HH:mm:ssZ") {
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
        }
        segSelected = bookingIDData.bookingType
        additionalSkillsSelected = bookingIDData.additionalSkills
        genderSelected = bookingIDData.gender
        yearsOfExperienceSelected = bookingIDData.yearsOfExprience
        languageSpeakingSelected = bookingIDData.languages
        needServiceInSelected = bookingIDData.areasOfExpertise
    }
    
    
    func getBookingForRelativeList(errorAlert: @escaping ((String)-> Void)){
        isloading = true
        NetworkManager.shared.getRelativeList { [weak self] result in
            DispatchQueue.main.async {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.bookingForList = data.data
                    if (self?.bookingID != "") {
                        self?.getBookingDetailsById(errorAlert: { errorStr in
                            errorAlert(errorStr)
                        })
                    }
                case .failure(let error):
                    errorAlert(error.getMessage())
                }
            }
        }
    }
    
    func getBookingDetailsById(errorAlert: @escaping ((String)-> Void)){
        isloading = true
        NetworkManager.shared.getBookingDetailsById(bookingId: bookingID) { [weak self] result in
            DispatchQueue.main.async {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.bookingIDData = data.data
                    self?.setPrefieldBookingData()
                case .failure(let error):
                    errorAlert(error.getMessage())
                }
            }
        }
    }
    
    
    func createBooking(action:(@escaping(String)->Void),alert:(@escaping(String)->Void)){
        
        if bookingFor.isEmpty{
         return alert("Please Select Person for this Booking.")
        }else if needServiceInSelected.count == 0{
            return alert("Please Select at list One Service.")
        }else if genderSelected.isEmpty{
            return alert("Please Select Preferred Service Provider Gender.")
        }else if languageSpeakingSelected.count == 0{
            return alert("Please Select Preferred Language.")
        }else if yearsOfExperienceSelected.isEmpty{
            return alert("Please Select Year of Experience.")
        }
        
        var param: [String: Any] = [
            "profile_id":bookingForList.filter{$0.name == bookingFor}.first?.id ?? "",
            "area_of_expertise":needServiceInSelected,
            "booking_type":segSelected,
            "start_date":segSelected == "One Time" ? selectedDay.serverDate : startDate,
            "end_date":segSelected == "One Time" ? selectedDay.serverDate : endDate,
            "start_time":startTime,
            "end_time":endTime,
            "gender":genderSelected,
            "language":languageSpeakingSelected,
            "years_of_exprience":[yearsOfExperienceSelected],
            "additional_skills":additionalSkillsSelected,
            "additional_info":additionalInfoSelected
        ]
        
        if bookingID != ""{
            param["booking_id"] = bookingID
        }
        
        if giverId != ""{
            param["caregiver_id"] = giverId
        }
        
        isloading = true
        NetworkManager.shared.createBooking(params:param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isloading = false
                switch result{
                case .success(let data):
                    action(data.data.id)
                case .failure(let error):
                    alert(error.getMessage())
                }
            }
        }
    }
}
