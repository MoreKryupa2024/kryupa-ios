//
//  WeakDayView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 28/05/24.
//

import SwiftUI

struct WeakDayData{
    var id: Int
    var day: String
    var numDay: String
    var serverDate: String
    var serverTime: String
}

struct WeakDayView: View {
    var selectionCount: Int = 4
    @State var selectedValue: WeakDayData? = nil
    var values: [WeakDayData] = Date.getDates(forLastNDays: 7)
    var onSelectedValue: ((WeakDayData)->Void)? = nil
    
    var body: some View {
        HStack(){
            ForEach(values,id: \.serverDate) { value in
                VStack(spacing:6){
                    dropDownView(value: value.day)
                    dropDownView(value: value.numDay)
                }
                    .frame(width: 40)
                    .padding(.vertical,12)
                    .background{
                        if let selectedValue{
                            Capsule()
                                .foregroundStyle((selectedValue.day == value.day) ? .appMain : .AEAEB_2)
                        }else{
                            Capsule()
                            .foregroundStyle(.appMain)
                        }
                        
                    }
                    .onTapGesture {
                        if value.id < selectionCount{
                            onSelectedValue?(value)
                            selectedValue = value
                        }
                    }
                
                if values.last?.day != value.day{
                    Spacer()
                }
            }
        }
    }
    
    private func dropDownView(value: String)-> some View{
        Text(value)
            .frame(maxWidth: .infinity)
            .font(.custom(FontContent.plusMedium, size: 11))
            .foregroundStyle(.white)
        
    }
}

#Preview {
    WeakDayView()
}
