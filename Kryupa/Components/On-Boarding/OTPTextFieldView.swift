//
//  OTPTextFieldView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 16/05/24.
//

import SwiftUI

struct OTPTextFieldView: View {
    
    let numberOfFields: Int
    @State var enterValue: [String]
    @FocusState private var focusState: Int?
    var onOtpEnterd: (([String])->Void)? = nil
    
    init(numberOfFields: Int, onOtpEnterd: (([String])->Void)?) {
        self.onOtpEnterd = onOtpEnterd
        self.numberOfFields = numberOfFields
        self.enterValue = Array(repeating: "", count: numberOfFields)
    }
    
    var body: some View {
        HStack(content: {
            ForEach(0..<numberOfFields,id: \.self) { index in
                OTPField(field: $enterValue[index])
                    .focused($focusState,equals: index)
                    .tag(index)
                    .onChange(of: enterValue[index], { oldValue, newValue in
                        if enterValue[index].count > 1{
                            
                            let currentValue = Array(enterValue[index])
                            if currentValue[0] == Character(oldValue){
                                enterValue[index] = String(enterValue[index].suffix(1))
                            }else{
                                enterValue[index] = String(enterValue[index].prefix(1))
                            }
                        }
                        if !newValue.isEmpty{
                            if index == numberOfFields - 1{
                                focusState = nil
                                onOtpEnterd?(enterValue)
                            }else{
                                focusState = (focusState ?? 0 ) + 1
                            }
                        }else{
                            focusState = (focusState ?? 0 ) - 1
                        }
                    })
                
                if index != (numberOfFields - 1){
                    Spacer()
                }
            }
        })
    }
    
    
    func OTPField(field: Binding<String>)-> some View{
        HStack() {
            
            TextField(text: field) {
                Text("0")
                    .foregroundStyle(._7_C_7_C_80)
            }
            .autocorrectionDisabled()
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .frame(height: 48)
            .font(.custom(FontContent.plusRegular, size: 22))
            
        }
        .background{
            RoundedRectangle(
                cornerRadius: 10
            )
            .stroke(lineWidth: 1)
            .foregroundStyle(.D_1_D_1_D_6)
        }
        .frame(width: 48,height: 48)
    }
}

#Preview {
    OTPTextFieldView(numberOfFields: 5, onOtpEnterd: nil)
}
