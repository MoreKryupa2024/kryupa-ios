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
    var price: Double? = nil
    
    
    var body: some View {
        HStack(alignment:.top,spacing: 5){
            Image(isSelected ? "checkboxUnselected" : "checkboxSelected")
                .resizable()
                .frame(width: 18,height: 18)
                .padding(.top,1.5)
            Text(name)
            if let price {
                Spacer()
                Text("($\(price.removeZerosFromEnd(num: 0))/hr)")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._018_ABE)
            }
        }
        .font(.custom(FontContent.plusRegular, size: 15))
        .foregroundStyle(.appMain)
    }
}

#Preview {
    CheckBoxView()
}
