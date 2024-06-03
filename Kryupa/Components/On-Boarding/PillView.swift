//
//  PillView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/05/24.
//

import SwiftUI

struct PillView: View {
    
    var isSelected: Bool = true
    var name: String = ""
    
    var body: some View {
        HStack(spacing: 4){
            Text(name)
        }
        .font(.custom(FontContent.plusMedium, size: 15))
        .padding(.vertical,8)
        .padding(.horizontal,20)
        .foregroundStyle(isSelected ? .white : .appMain)
        .background(isSelected ? .appMain : .E_5_E_5_EA)
        .cornerRadius(48)
    }
}

#Preview {
    PillView()
}
