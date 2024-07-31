//
//  DropDownWithCheckBoxView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 06/06/24.
//

import SwiftUI

struct DropDownWithCheckBoxView: View {
    
    @State var selectedValue: [String] = [String]()
    var placeHolder: String = "Select"
    @State private var showDropDown: Bool = false
    var values: [String] = AppConstants.medicalConditionArray
    
    var onSelectedValue: (([String])->Void)? = nil
    
    var body: some View {
        VStack(spacing:0){
            
            HStack(spacing:0){
                
                if !selectedValue.isEmpty{
                    Text(selectedValue.joined(separator: ","))
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundStyle(.appMain)
                        .lineLimit(1)
                    
                }else{
                    Text(placeHolder)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .foregroundStyle(._7_C_7_C_80)
                }
                    
                
                Image("PersonalInfoDropDown")
                    .padding(.horizontal,12)
                    .frame(width: 24,height: 24)
                
            }
            .frame(height: 48)
            .font(.custom(FontContent.plusRegular, size: 15))
            .padding([.leading,.trailing],10)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundStyle(.D_1_D_1_D_6)
                    .frame(height: 48)
                    .background(.white)
            }
            .onTapGesture {
                showDropDown.toggle()
            }
            
            
            if showDropDown{
                ScrollView{
                    LazyVStack(spacing: 15){
                        ForEach(values, id: \.self) { value in
                            dropDownView(value: value)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .padding(.horizontal,10)
                                .background()
                                .onTapGesture {
                                    
                                    if value == "None"{
                                        showDropDown = false
                                        selectedValue = [value]
                                    }else{
                                        if selectedValue.contains(value){
                                            selectedValue = selectedValue.filter{$0 != value}
                                        }else{
                                            if selectedValue.contains("None"){
                                                selectedValue = []
                                            }
                                            selectedValue.append(value)
                                        }
                                    }
                                    onSelectedValue?(selectedValue)
                                }
                        }
                    }
                    .padding([.top,.bottom],15)
                }
                .frame(height: values.count > 4 ? 200 : .infinity)
            }
        }
        .background{
            RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 1)
                .foregroundStyle(.D_1_D_1_D_6)
        }
        
    }
    
    private func dropDownView(value: String)-> some View{
        HStack(spacing:0){
            
            Text(value)
                .frame(maxWidth: .infinity,alignment: .leading)
                .font(
                    .custom(
                        (selectedValue.contains(value)) ? FontContent.plusMedium : FontContent.plusRegular ,
                        size: 15
                    )
                )
            if value != "None"{
                Image(!(selectedValue.contains(value)) ? "checkboxUnselected" : "checkboxSelected")
                    .padding(.trailing,12)
                    .frame(width: 24,height: 24)
            }
        }
    }
}

#Preview {
    DropDownWithCheckBoxView()
}
