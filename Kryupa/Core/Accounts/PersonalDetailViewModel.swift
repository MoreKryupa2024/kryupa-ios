//
//  PersonalDetailViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 10/06/24.
//

import Foundation

class PersonalDetailViewModel: ObservableObject{
    
    @Published var additionalInfoSelected: [String] = [String]()
    @Published var education: String = String()
    @Published var educationList = ["Degree 1", "Degree 2", "Degree 3"]
    @Published var languageDropDownSelected: [String] = [String]()
    @Published var languageList = ["Hindi", "English", "French", "Spanish"]

}
