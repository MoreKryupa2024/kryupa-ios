//
//  CheckBoxView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/05/24.
//

import SwiftUI

struct CheckBoxView: View {
    var isSelected: Bool = true
    var name: String = "Physical Therapy"
    
    
    var body: some View {
        HStack(spacing: 5){
            Image(isSelected ? "checkboxUnselected" : "checkboxSelected")
                .resizable()
                .frame(width: 18,height: 18)
            Text(name)
        }
        .font(.custom(FontContent.plusRegular, size: 12))
        .foregroundStyle(.appMain)
    }
}

#Preview {
    CheckBoxView()
}
