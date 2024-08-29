//
//  RecommandedListScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 20/08/24.
//

import SwiftUI
import SwiftfulUI

struct RecommandedListScreenView: View {
    
    @Environment(\.router) var router
    var recommendedCaregiver: [RecommendedCaregiverData] = [RecommendedCaregiverData]()
    
    var body: some View {
        ZStack{
            VStack(spacing:15){
                HeaderView(showBackButton:true)
                ScrollView{
                    CaregiverNearYouView
                }
                .scrollIndicators(.hidden)
            }
        }
        .modifier(DismissingKeyboard())
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var CaregiverNearYouView: some View{
        VStack(spacing:0){
            Text("Recommended Caregivers")
                .font(.custom(FontContent.besMedium, size: 20))
                .padding(.top,21)
            
            VStack(spacing:0){
                ForEach(Array(recommendedCaregiver.enumerated()),id: \.element.id){ (index,giver) in
                    giverView(giver: giver)
                        .padding(.top,15)
                        .asButton(.press) {
                            var recommendedCareGiverDetailScreenViewModel = RecommendedCareGiverDetailScreenViewModel()
                            recommendedCareGiverDetailScreenViewModel.isRecommended = true
                            
                            let careGiverDetails = CareGiverNearByCustomerScreenData(jsonData: [
                                "id":giver.id,
                                "profile_picture_url":giver.profileURL,
                                "name": giver.name])
                            
                            router.showScreen(.push) { rout in
                                RecommendedCareGiverDetailScreenView(careGiverDetail: careGiverDetails,viewModel: recommendedCareGiverDetailScreenViewModel)
                            }
                        }
                }
            }
            .padding(.horizontal,24)
        }
    }
    
    private func giverView(giver:RecommendedCaregiverData)-> some View{
        HStack(spacing:0){
            
            ImageLoadingView(imageURL:giver.profileURL)
                .frame(width: 64,height: 64)
                .clipShape(.rect(cornerRadius: 32))
                .clipped()
            
            VStack(alignment:.leading, spacing:0){
                Text(giver.name)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .font(.custom(FontContent.besMedium, size: 17))
                
                Text("\(giver.yearOfExprience.removeZerosFromEnd(num: 0)) Years Expirenced")
                    .font(.custom(FontContent.plusRegular, size: 12))
                    .padding(.bottom,5)
                
                HStack{
                    StarsView(rating: Double(giver.rating) ?? 0.0, maxRating: 5, size: 12)
                    
                    Text("( \(giver.reviewCount) )")
                        .font(.custom(FontContent.plusRegular, size: 11))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.leading,23)
            
            Text("$\(giver.pricePerHour.removeZerosFromEnd(num: 2))")
                .font(.custom(FontContent.plusMedium, size: 12))
                .frame(maxHeight: .infinity,alignment: .top)
        }
        .padding(.vertical,9)
        .padding(.horizontal,10)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
        }
    }
}

#Preview {
    CareGiverNearByCustomerScreenView()
}
