//
//  CircleCheckBoxView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/05/24.
//

import SwiftUI

struct CircleCheckBoxView: View {
    var isSelected: Bool = true
    var name: String = "Physical Therapy"
    var price: Double? = nil
    var color: Color = .appMain
    
    var body: some View {
        HStack(alignment:.top,spacing: 5){
            Image(isSelected ? "radioUnselected" : "radioSelected")
                .resizable()
                .frame(width: 18,height: 18)
                .padding(.top,1.5)
            VStack{
                if name.contains("("){
                    let name = name.split(separator: "(").first ?? ""
                    let extra = self.name.split(separator: "(").last ?? ""
                    Text(name)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Text("(\(extra)")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .font(.custom(FontContent.plusRegular, size: 9))
                }else{
                    Text(name)
                }
            }
            .foregroundStyle(self.color)
            if let price {
                Spacer()
                Text("($\(price.removeZerosFromEnd(num: 0))/hr)")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .foregroundStyle(._018_ABE)
            }
        }
        .font(.custom(FontContent.plusRegular, size: 15))
        .foregroundStyle(.appMain)
    }
}

#Preview {
    CircleCheckBoxView()
}
