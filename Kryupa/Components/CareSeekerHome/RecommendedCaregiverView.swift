//
//  RecommendedCaregiverView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 31/05/24.
//

import SwiftUI
import SwiftfulUI

struct RecommendedCaregiverView: View {
    var recommendedCaregiver: [RecommendedCaregiverData] = [RecommendedCaregiverData]()
    var selectedGiver: ((RecommendedCaregiverData)-> Void)? = nil
    let profileWidth:CGFloat = CGFloat((UIScreen.screenWidth - (68))/2.2)
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing:10){
//                ForEach(recommendedCaregiver,id: \.id) { index in
                ForEach(recommendedCaregiver, id: \.id) { careData in
                    
                    VStack(spacing:0){
                        
                        ImageLoadingView(imageURL: careData.profileURL)
                            .frame(height: 97)
                            .clipShape(.rect(cornerRadius: 5))
                            .clipped()
                        
                        HStack(spacing:2){
                            Text(careData.name)
                                .font(.custom(FontContent.plusMedium, size: 13))
                                .lineLimit(1)
                            Spacer()
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 11,height: 11)
                            Text(careData.rating)
                                .font(.custom(FontContent.plusRegular, size: 11))
                        }
                        .padding(.top,5)
                        
                        Text("(\(careData.arrayAgg.joined(separator: ", "))")
                            .font(.custom(FontContent.plusRegular, size: 11))
                            .multilineTextAlignment(.center)
                            .foregroundStyle(._444446)
                            .padding(.top,10)
                            .lineLimit(1)
                        
                        Text("View Profile")
                            .font(.custom(FontContent.plusRegular, size: 13))
                            .foregroundStyle(.white)
                            .padding(.horizontal,20)
                            .padding(.vertical,8)
                            .background{
                                RoundedRectangle(cornerRadius: 16)
                            }
                            .padding(.top,10)
                    }
                    .frame(width: profileWidth)
                    .padding([.vertical,.horizontal],9)
                    .background{
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.F_2_F_2_F_7)
                    }
                    .overlay {}
                    .asButton(.press) {
                        selectedGiver?(careData)
                    }
                }
            }
            .padding(.horizontal,24)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    RecommendedCaregiverView()
}
