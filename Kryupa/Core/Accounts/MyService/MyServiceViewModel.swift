//
//  MyServiceViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import Foundation

class MyServiceViewModel: ObservableObject{
    
    @Published var areaOfExpertiseSelected: [String] = [String]()
    @Published var areaOfExpertiseList = ["Physical Therapy", "Occupational Therapy", "Nursing", "Companianship"]
    @Published var mySkillsSelected: [String] = [String]()
    @Published var mySkillsList = ["Respite Care", "Live in home care", "Transportation", "Errands / shopping", "Light housecleaning", "Meal preparation", "Help with staying physically active", "Medical Transportation", "Dementia", "Bathing / dressing", "Companionship", "Feeding", "Mobility Assistance", "Heavy lifting"]
    
//    func getMyservice

}
