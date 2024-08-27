//
//  ReviewHoursView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 17/06/24.
//

import SwiftUI

struct ReviewHoursView: View {
    var ratePerHr = "$20.23"
    var noOfHrs = 6
    var total = 121.38

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Rate per hour:")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
                
                Spacer()
                
                Text("$\(ratePerHr)")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
            }
            
            HStack {
                Text("Number of hours:")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
                
                Spacer()
                
                Text("\(noOfHrs)")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
            }
            if AppConstants.SeekCare == Defaults().userType{
                HStack {
                    Text("Platform Fee:")
                        .font(.custom(FontContent.plusRegular, size: 15))
                        .foregroundStyle(.appMain)
                    
                    Spacer()
                    
                    Text("2%")
                        .font(.custom(FontContent.plusRegular, size: 16))
                        .foregroundStyle(.appMain)
                }
            }
            
            HStack {
                Text("Total:")
                    .font(.custom(FontContent.plusRegular, size: 15))
                    .foregroundStyle(.appMain)
                
                Spacer()
                
                Text("$\(String(format: "%.2f", total))")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.appMain)
            }
        }
        .padding([.horizontal, .top], 24)
    }
}

#Preview {
    ReviewHoursView()
}
