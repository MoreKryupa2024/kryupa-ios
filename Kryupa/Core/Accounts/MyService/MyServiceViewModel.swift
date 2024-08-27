//
//  MyServiceViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import Foundation

@MainActor
class MyServiceViewModel: ObservableObject{
    
    @Published var areaOfExpertiseSelected: [String] = [String]()
    var areaOfExpertiseList = ["Physical Therapy", "Occupational Therapy", "Nursing", "Companianship"]
    @Published var mySkillsSelected: [String] = [String]()
    var mySkillsList = ["Respite Care", "Live in home care", "Transportation", "Errands / shopping", "Light housecleaning", "Meal preparation", "Help with staying physically active", "Medical Transportation", "Dementia", "Bathing / dressing", "Companionship", "Feeding", "Mobility Assistance", "Heavy lifting"]
    @Published var isLoading: Bool = false
    
    func getMyService(){
        isLoading = true
        DispatchQueue.main.async {
            NetworkManager.shared.getMyServices { [weak self] result in
                self?.isLoading = false
                switch result{
                case .success(let data):
                    self?.areaOfExpertiseSelected = data.data.areaOfExperties
                    self?.mySkillsSelected = data.data.skilles
                case .failure(let error):
                    print(error.getMessage())
                }
            }
        }
    }
    
    func updateMyService(error: @escaping (String)-> Void){
        DispatchQueue.main.async {
            if self.areaOfExpertiseSelected.count == 0 {
                error("Please select at list one area of Expertise")
                return
            }
            
            var param:[String:Any] = ["skilles":self.mySkillsSelected,
                                      "areaOfExperties":self.areaOfExpertiseSelected]
            self.isLoading = true
            NetworkManager.shared.updateMyService(params: param) { [weak self] result in
                self?.isLoading = false
                switch result{
                case .success(let data):
                    error("Your Service Updated Successfully")
                case .failure(let errors):
                    error(errors.getMessage())
                }
            }
        }
    }
}
