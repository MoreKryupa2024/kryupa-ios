//
//  DropDownView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/05/24.
//

import SwiftUI
import SwiftfulUI

struct DropDownView: View {
    
    @State var selectedValue: String? = nil
    var placeHolder: String = "Select"
    var showDropDown: Bool = Bool()
    var values: [String] = ["Full mobility","Moderate mobility","Limited mobility","Wheelchair-bound","Bedridden","Bedridden","Full mobility","Moderate mobility","Limited mobility","Wheelchair-bound","Bedridden","Bedridden"]
//    var values: [String] = ["Full mobility","Moderate mobility","Limited mobility"]
    
    var onSelectedValue: ((String)->Void)? = nil
    var onShowValue: (()->Void)? = nil
    
    var body: some View {
        VStack(spacing:0){
            
            HStack(spacing:0){
                
                if let selectedValue, !selectedValue.isEmpty{
                    Text(selectedValue)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundStyle(.appMain)
                    
                }else{
                    Text(placeHolder)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundStyle(._7_C_7_C_80)
                }
                    
                
                Image("PersonalInfoDropDown")
                    .padding(.trailing,12)
                    .frame(width: 24,height: 24)
                
            }
            .frame(height: 48)
            .font(.custom(FontContent.plusRegular, size: 15))
            .padding([.leading,.trailing],10)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(showDropDown ? ._018_ABE : .D_1_D_1_D_6)
                    .frame(height: 48)
                    .background(.white)
            }
            .asButton {
                onShowValue?()
//                showDropDown = !showDropDown
                dismissingKeyboardGlobal()
            }
            
            if showDropDown{
                if values.count > 4{
                    ScrollView{
                        VStack(spacing: 15){
                            ForEach(values, id: \.self) { value in
                                dropDownView(value: value)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.horizontal,10)
                                    .asButton {
                                        onSelectedValue?(value)
                                        selectedValue = value
//                                        showDropDown = false
                                        onShowValue?()
                                        dismissingKeyboardGlobal()
                                    }
                            }
                        }
                        .padding([.top],15)
                    }
                    .frame(height: 200)
                }else{
                    ScrollView{
                        VStack(spacing: 15){
                            ForEach(values, id: \.self) { value in
                                dropDownView(value: value)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                    .padding(.horizontal,10)
                                    .asButton {
                                        onSelectedValue?(value)
                                        selectedValue = value
//                                        showDropDown = false
                                        onShowValue?()
                                        dismissingKeyboardGlobal()
                                    }
                            }
                        }
                        .padding([.top,.bottom],15)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .background{
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundStyle(.D_1_D_1_D_6)
        }
        
    }
    
    private func dropDownView(value: String)-> some View{
        if let selectedValue{
            Text(value)
                .foregroundStyle((selectedValue != value) ? .appMain : ._018_ABE)
        }else{
            Text(value)
                .foregroundStyle(.appMain)
        }
    }
}

#Preview {
    DropDownView()
}
