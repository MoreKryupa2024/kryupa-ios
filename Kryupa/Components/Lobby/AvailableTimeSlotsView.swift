//
//  AvailableTimeSlotsView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 28/05/24.
//

import SwiftUI

struct AvailableTimeSlotsView: View {
    var isSelected: Bool = false
    var availablity: String = "Available"
    var availablityTime: String = "10:00am - 10:30am"
    
    var body: some View {
        HStack(spacing:0){
            
            VStack(alignment:.leading,spacing:4){
                Text(availablity)
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
                
                Text(availablityTime)
                    .font(.custom(FontContent.plusRegular, size: 13))
                    .foregroundStyle(._7_C_7_C_80)
            }
            .frame(maxWidth: .infinity,alignment: .leading)
            
            Image("calendarTimeSlot")
                .frame(width: 30,height: 30)
        }
        .padding([.leading,.trailing],24)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .frame(height: 64)
                .background(isSelected ? .D_1_D_1_D_6 : .white)
                .clipShape(.rect(cornerRadius: 10))
                .foregroundStyle(.E_5_E_5_EA)
        }
        .padding(.bottom,40)
    }
}

#Preview {
    AvailableTimeSlotsView()
}
