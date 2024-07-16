//
//  DateTimePickerScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 21/06/24.
//

import SwiftUI
import SwiftfulUI

struct DateTimePickerScreenView: View {
    
    @State private var givenDate:Date = Date()
    var formate:String = ""
    var range: PartialRangeFrom? = Date()...
    var rangeThrough: PartialRangeThrough? = ...Date()
    var valueStr: ((String)->Void)? = nil
    var displayedComponents: DatePickerComponents = .date
    var valueDate: ((Date)->Void)? = nil
    
    var body: some View {
        ZStack{
            VStack{
                if let range {
                    DatePicker("Calender", selection: $givenDate, in: range, displayedComponents: displayedComponents )
                        .datePickerStyle(.graphical)
                }else if let rangeThrough {
                    DatePicker("Calender", selection: $givenDate, in: rangeThrough, displayedComponents: displayedComponents )
                        .datePickerStyle(.graphical)
                }else{
                    DatePicker("Calender", selection: $givenDate, displayedComponents: displayedComponents )
                        .datePickerStyle(.graphical)
                }
                HStack{
                    Spacer()
                    Text("Done")
                        .padding(10)
                        .foregroundStyle(.white)
                        .background{
                            Color.blue
                        }
                        .cornerRadius(5)
                    
                }
                .asButton(.press) {
                    valueStr?(dateFormatChange(dateFormat: formate, dates: $givenDate.wrappedValue))
                    valueDate?($givenDate.wrappedValue)
                }
            }
            .padding()
        }
    }
}

#Preview {
    DateTimePickerScreenView()
}
