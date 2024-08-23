//
//  DateTimePickerScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 21/06/24.
//

import SwiftUI
import SwiftfulUI

struct DateTimePickerScreenView: View {
    
    @State var givenDate:Date = Date()
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
                    DatePicker("", selection: $givenDate, in: range, displayedComponents: displayedComponents )
                        .datePickerStyle(.wheel)
                }else if let rangeThrough {
                    DatePicker("", selection: $givenDate, in: rangeThrough, displayedComponents: displayedComponents )
                        .datePickerStyle(.wheel)
                }else{
                    DatePicker("", selection: $givenDate, displayedComponents: displayedComponents )
                        .datePickerStyle(.wheel)
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
                    print(givenDate)
                    print(dateFormatChange(dateFormat: formate, dates: $givenDate.wrappedValue))
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
