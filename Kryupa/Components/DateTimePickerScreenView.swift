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
    var cancelAction: (()->Void)? = nil
    
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.1)
            ZStack{
                VStack {
                    if let range {
                        if displayedComponents == .date{
                            DatePicker(selection: $givenDate,
                                       in: range ,
                                       displayedComponents: displayedComponents){}
                                .datePickerStyle(.graphical)
                        }else{
                            DatePicker(selection: $givenDate,
                                       in: range ,
                                       displayedComponents: displayedComponents){}
                                .datePickerStyle(.wheel)
                        }
                    }else if let rangeThrough {
                        
                        if displayedComponents == .date{
                            DatePicker(selection: $givenDate,
                                       in: rangeThrough ,
                                       displayedComponents: displayedComponents){}
                                .datePickerStyle(.graphical)
                        }else{
                            DatePicker(selection: $givenDate,
                                       in: rangeThrough ,
                                       displayedComponents: displayedComponents){}
                                .datePickerStyle(.wheel)
                        }
                    }else{
                        if displayedComponents == .date{
                            DatePicker(selection: $givenDate,
                                       displayedComponents: displayedComponents){}
                                .datePickerStyle(.graphical)
                        }else{
                            DatePicker(selection: $givenDate,
                                       displayedComponents: displayedComponents){}
                                .datePickerStyle(.wheel)
                        }
                    }
                    
                    HStack(spacing: 15){
                        Text("Cancel")
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .foregroundStyle(.black)
                            .cornerRadius(5)
                            .asButton {
                                cancelAction?()
                            }
                        Text("Done")
                            .frame(maxWidth: .infinity)
                            .padding(10)
                            .foregroundStyle(.white)
                            .background{
                                Color.blue
                            }
                            .cornerRadius(5)
                            .asButton(.press) {
                                print(givenDate)
                                print(dateFormatChange(dateFormat: formate, dates: $givenDate.wrappedValue))
                                valueStr?(dateFormatChange(dateFormat: formate, dates: $givenDate.wrappedValue))
                                valueDate?($givenDate.wrappedValue)
                            }
                    }
                    
                }
                .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.white)
                    .shadow(radius: 2)
            )
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
//        .asButton {
//            print("No access!")
//        }
    }
}

#Preview {
    DateTimePickerScreenView()
}
