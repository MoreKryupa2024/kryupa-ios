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
                    .onChange(of: enterValue[index]) { oldValue, newValue in
                        guard !newValue.isEmpty else {
                            // Adjust focus state when the field is cleared
                            focusState = max((focusState ?? 0) - 1, 0)
                            return
                        }
                        
                        // Ensure the field contains only one character
                        if newValue.count > 1 {
                            let firstCharacter = newValue.first
                            if firstCharacter == oldValue.first {
                                enterValue[index] = String(newValue.suffix(1)) // Keep the last character
                            } else {
                                enterValue[index] = String(newValue.prefix(1)) // Keep the first character
                            }
                        }
                        
                        // Adjust focus or call onOtpEntered when appropriate
                        if index == numberOfFields - 1 {
                            focusState = nil
                            onOtpEnterd?(enterValue)
                        } else {
                            focusState = (focusState ?? 0) + 1
                        }
                    }
                
                if index != (numberOfFields - 1){
                    Spacer()
                }
            }
        })
    }
    
    
    func OTPField(field: Binding<String>) -> some View {
        TextField(text: field){
            Text("0")
                .foregroundStyle(._7_C_7_C_80)
        }
        .autocorrectionDisabled()
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        .font(.custom(FontContent.plusRegular, size: 22))
        .frame(width: 48, height: 48)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundStyle(.D_1_D_1_D_6)
        )
    }
}

#Preview {
    OTPTextFieldView(numberOfFields: 5, onOtpEnterd: nil)
}
