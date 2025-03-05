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
    @Published var startTimeValue: Date = (Calendar.current as NSCalendar).date(byAdding: .minute, value: 16, to: Date(), options: [])!
    
    @Published var bookingFor: String = String()
    @Published var giverName: String = String()
    @Published var giverId: String = String()
    @Published var segSelected: String = "One Time"
    @Published var bookingForList: [RelativeDataModel] = [RelativeDataModel]()
    @Published var needServiceInArray: [PricingArray] = [PricingArray]()
    
    @Published var genderSelected: String = String()
    
    var bookingID: String = String()
    var draftId: String = Defaults().draftId
    @Published var bookingIDData: BookingIDData?
    @Published var draftDetailData: DraftListData?
    
    @Published var languageSpeakingSelected: [String] = ["English"]
    @Published var needServiceInSelected: [String] = [String]()
    @Published var additionalInfoSelected: [String] = [String]()
    @Published var additionalSkillsSelected: [String] = [String]()
    @Published var yearsOfExperienceSelected: String = "Any"
    @Published var isloading: Bool = Bool()
    @Published var isRecommended: Bool = false
    @Published var recommendedUserBookingData: RecommendedUserBookingData?
    
    func getCustomerRequirements(errorAlert: @escaping ((String)-> Void)){
        let param = ["profile_id":Defaults().profileId]
        isloading = true
        NetworkManager.shared.getCustomerRequirements(param:param) { [weak self] result in
            DispatchQueue.main.async {
                self?.isloading = false
                switch result{
                case .success(let data):
                    self?.recommendedUserBookingData = data.data.preference
                    self?.genderSelected = data.data.preference.gender
                    self?.yearsOfExperienceSelected = data.data.preference.yearOfExperience
//                    self?.needServiceInSelected = data.data.preference.preferredServiceType
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
            let strDate = (bookingIDData.startDateArray.first ?? "").convertDateFormaterTimeZone(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", afterFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            startDateValue = dateFormatChangeToDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",dates: strDate) ?? Date()
        }else{
            for i in bookingIDData.startDateArray{
                let strDate = i.convertDateFormaterTimeZone(beforeFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", afterFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                let date = (dateFormatChangeToDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", dates: strDate) ?? Date())
                let comps = Calendar.current.dateComponents([.calendar,.era,.year, .month, .day,.isLeapMonth], from: date)
                startDateSValue.insert(comps)
            }
        }
    }
    
    func setPrefieldDraftData(){
        guard let draftDetailData else {
            return
        }
        duration = Int(draftDetailData.hours) ?? 1
        bookingFor = bookingForList.filter{$0.id == draftDetailData.profileID}.first?.name ?? ""
        segSelected = draftDetailData.bookingType
        additionalSkillsSelected = draftDetailData.additionalSkills
        additionalInfoSelected = draftDetailData.additionalInfo
        genderSelected = draftDetailData.gender
        yearsOfExperienceSelected = draftDetailData.yearOfExp
        languageSpeakingSelected = draftDetailData.lang
        startTimeValue = dateFormatChangeToDate(dateFormat: "yyyy-MM-ddHH:mm:ss",dates: "\(draftDetailData.dates.first ?? "")\(draftDetailData.startTime)") ?? Date()
        needServiceInSelected = [draftDetailData.needServiceIn]
        if segSelected == "One Time"{
            let strDate = (draftDetailData.dates.first ?? "").convertDateFormaterTimeZone(beforeFormat: "yyyy-MM-dd", afterFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            startDateValue = dateFormatChangeToDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",dates: strDate) ?? Date()
        }else{
            for i in draftDetailData.dates{
                let strDate = i.convertDateFormaterTimeZone(beforeFormat: "yyyy-MM-dd", afterFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                let date = (dateFormatChangeToDate(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", dates: strDate) ?? Date())
                let comps = Calendar.current.dateComponents([.calendar,.era,.year, .month, .day,.isLeapMonth], from: date)
                startDateSValue.insert(comps)
            }
        }
    }
    
    func getBookingForRelativeList(errorAlert: @escaping ((String)-> Void)){
        let param = ["caregiver_id":giverId]
        isloading = true
        NetworkManager.shared.getRelativeList(params: param) { [weak self]
            result in
            
            guard let self else{ return }
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self.isloading = false
                    self.bookingForList = data.data.relationArray
                    self.bookingFor = (self.bookingForList.filter{$0.profileId == Defaults().profileId}).first?.name ?? ""
                    self.needServiceInArray = data.data.pricingArray
                    if (self.bookingID != "") {
                        self.getBookingDetailsById(errorAlert: { errorStr in
                            errorAlert(errorStr)
                        })
                    } else if (self.draftId != "") {
                        self.getDraftDetailsById(errorAlert: { errorStr in
                            errorAlert(errorStr)
                        })
                    }
                case .failure(let error):
                    self.isloading = false
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
    
    func getDraftDetailsById(errorAlert: @escaping ((String)-> Void)){
        isloading = true
        NetworkManager.shared.getDraftDetails(draftId: draftId) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let data):
                    self?.isloading = false
                    self?.draftDetailData = data.data
                    self?.setPrefieldDraftData()
                case .failure(let error):
                    self?.isloading = false
                    errorAlert(error.getMessage())
                }
            }
        }
    }
    
    func saveToDraft(action:(@escaping(String)->Void),alert:(@escaping(String)->Void)){
        
        dateArray = dateArray.sorted{$0 < $1}
        let selectedDate = dateFormatChange(dateFormat: "yyyy-MM-dd", dates: startDateValue)
        let currentDate = dateFormatChange(dateFormat: "yyyy-MM-dd", dates: Date())
        let date = (Calendar.current as NSCalendar).date(byAdding: .minute, value: 15, to: Date(), options: [])!
        if bookingFor.isEmpty{
         return alert("Please Select Person for this Booking.")
        }else if needServiceInSelected.count == 0{
            return alert("Please Select at list One Service.")
        }else if segSelected != "One Time" && startDateSValue.count == 0{
            return alert("Please Select Recurring Dates.")
        }else if currentDate > selectedDate && segSelected == "One Time"{
            return alert("The selected date has already passed. Please choose a future/Current date.")
        }else if showDatePicker && segSelected == "One Time"{
            return alert("Please Confirm the Selected Date.")
        }else if showTimePicker{
            return alert("Please Confirm the Selected Time.")
        }else if genderSelected.isEmpty{
            return alert("Please Select Preferred Service Provider Gender.")
        }else if languageSpeakingSelected.count == 0{
            return alert("Please Select Preferred Language.")
        }else if yearsOfExperienceSelected.isEmpty{
            return alert("Please Select Year of Experience.")
        }else if startTimeValue < date && !(Date() < startDateValue) && segSelected == "One Time" {
            return alert("Ensure the booking time is at least 15 minutes from now.")
        }else if segSelected != "One Time" && dateArray.contains(dateFormatChange(dateFormat: "yyyy-MM-dd", dates: Date())) && startTimeValue < date{
            return alert("Ensure the booking time is at least 15 minutes from now.")
        }
        
        var param: [String: Any] = [
            "profile_id": bookingForList.filter{$0.name == bookingFor}.first?.id ?? "",
            "need_service_in": needServiceInSelected.first ?? "",
            "booking_type": segSelected,
            "hours": duration,
            "start_time": dateFormatChange(dateFormat: "HH:mm:ss", dates: startTimeValue),
            "gender": genderSelected,
            "year_of_exp": yearsOfExperienceSelected,
            "language": languageSpeakingSelected,
            "dates": segSelected == "One Time" ? [dateFormatChange(dateFormat: "yyyy-MM-dd", dates: startDateValue)] : dateArray,
            "additional_skills": additionalSkillsSelected,
            "additional_info": additionalInfoSelected,
            ]
        
        if draftId != ""{
            param["draft_id"] = draftId
        }
        
        if giverId != ""{
            param["caregiver_id"] = giverId
        }
        
        isloading = true
        NetworkManager.shared.createDraftBooking(params:param) { [weak self] result in
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
    
    
    func createBooking(action:(@escaping(String)->Void),alert:(@escaping(String)->Void)){
        dateArray = dateArray.sorted{$0 < $1}
        
        let date = (Calendar.current as NSCalendar).date(byAdding: .minute, value: 15, to: Date(), options: [])!
        let selectedDate = dateFormatChange(dateFormat: "yyyy-MM-dd", dates: startDateValue)
        let currentDate = dateFormatChange(dateFormat: "yyyy-MM-dd", dates: Date())
        if bookingFor.isEmpty{
         return alert("Please Select Person for this Booking.")
        }else if needServiceInSelected.count == 0{
            return alert("Please Select at list One Service.")
        }else if segSelected != "One Time" && startDateSValue.count == 0{
            return alert("Please Select Recurring Dates.")
        }else if showDatePicker && segSelected == "One Time"{
            return alert("Please Confirm the Selected Date.")
        }else if currentDate > selectedDate && segSelected == "One Time"{
            return alert("The selected date has already passed. Please choose a future/Current date.")
        }else if showTimePicker{
            return alert("Please Confirm the Selected Time.")
        }else if genderSelected.isEmpty{
            return alert("Please Select Preferred Service Provider Gender.")
        }else if languageSpeakingSelected.count == 0{
            return alert("Please Select Preferred Language.")
        }else if yearsOfExperienceSelected.isEmpty{
            return alert("Please Select Year of Experience.")
        }else if startTimeValue < date && !(Date() < startDateValue) && segSelected == "One Time" {
            return alert("Ensure the booking time is at least 15 minutes from now.")
        }else if segSelected != "One Time" && dateArray.contains(dateFormatChange(dateFormat: "yyyy-MM-dd", dates: Date())) && startTimeValue < date{
            return alert("Ensure the booking time is at least 15 minutes from now.")
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
        
        if draftId != ""{
            param["draft_id"] = draftId
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
