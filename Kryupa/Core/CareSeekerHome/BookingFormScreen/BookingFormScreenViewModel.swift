//
//  BookingFormScreenViewModel.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 31/05/24.
//

import Foundation

class BookingFormScreenViewModel: ObservableObject{
    @Published var showDatePicker: Bool = Bool()
    @Published var showTimePicker: Bool = Bool()
    var dateState: Int = Int()
    @Published var duration: Int = 1
    var dateArray:[String] = []
    @Published var startDateValue: Date = Date()
    @Published var startDateSValue: Set<DateComponents> = []
    @Published var startTimeValue: Date = Date()
    
    @Published var bookingFor: String = String()
    @Published var giverName: String = String()
    @Published var giverId: String = String()
    @Published var segSelected: String = "One Time"
    @Published var bookingForList: [RelativeDataModel] = [RelativeDataModel]()
    @Published var needServiceInArray: [PricingArray] = [PricingArray]()
    
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
        duration = bookingIDData.noOfHours
        bookingFor = bookingForList.filter{$0.id == bookingIDData.profileID}.first?.name ?? ""
        segSelected = bookingIDData.bookingType
        additionalSkillsSelected = bookingIDData.additionalSkills
        genderSelected = bookingIDData.gender
        yearsOfExperienceSelected = bookingIDData.yearsOfExprience
        languageSpeakingSelected = bookingIDData.languages
        needServiceInSelected = bookingIDData.areasOfExpertise
        if segSelected == "One Time"{
            startDateValue = dateFormatChangeToDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",dates: bookingIDData.startDateArray.first ?? "") ?? Date()
        }else{
            for i in bookingIDData.startDateArray{
                let date = (dateFormatChangeToDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", dates: i) ?? Date())
                let comps = Calendar.current.dateComponents([.calendar,.era,.year, .month, .day,.isLeapMonth], from: date)
                startDateSValue.insert(comps)
            }
        }
    }
    
    func getBookingForRelativeList(errorAlert: @escaping ((String)-> Void)){
        isloading = true
        NetworkManager.shared.getRelativeList { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.bookingForList = data.data.relationArray
                    self?.needServiceInArray = data.data.pricingArray
                    if (self?.bookingID != "") {
                        self?.getBookingDetailsById(errorAlert: { errorStr in
                            errorAlert(errorStr)
                        })
                    }
                case .failure(let error):
                    self?.isloading = false
                    errorAlert(error.getMessage())
                }
            }
        }
    }
    
    func getBookingDetailsById(errorAlert: @escaping ((String)-> Void)){
        isloading = true
        NetworkManager.shared.getBookingDetailsById(bookingId: bookingID) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.bookingIDData = data.data
                    self?.setPrefieldBookingData()
                case .failure(let error):
                    self?.isloading = false
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
        }else if segSelected != "One Time" && startDateSValue.count == 0{
            return alert("Please Select Recurring Dates.")
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
            
            "start_date_array":segSelected == "One Time" ? [dateFormatChange(dateFormat: "yyyy-MM-dd", dates: startDateValue)] : dateArray,
            "start_time":dateFormatChange(dateFormat: "HH:mm:ss", dates: startTimeValue),
            "no_of_hours":duration,
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
