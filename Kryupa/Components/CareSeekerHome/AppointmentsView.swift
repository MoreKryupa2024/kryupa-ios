//
//  AppointmentsView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 12/06/24.
//

import SwiftUI

struct AppointmentsView: View {
    
    var appointmentList: [AppointmentData] = [AppointmentData]()
    let viewWidth:CGFloat = CGFloat((UIScreen.screenWidth - (80)))
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing:10){
                ForEach(appointmentList,id: \.id) { data in
                    
                    VStack(spacing:0){
                        HStack(spacing:15){
                            
                            ImageLoadingView(imageURL: data.profilePictureURL)
                                .frame(width: 50,height: 50)
                                .clipShape(.rect(cornerRadius: 25))
                            
                            VStack(alignment:.leading, spacing:0){
                                Text(data.name)
                                    .font(.custom(FontContent.besMedium, size: 17))
                                    .frame(maxWidth:.infinity,alignment: .leading)
                                Text("For Myself")
                                    .font(.custom(FontContent.plusRegular, size: 11))
                                    .foregroundStyle(._7_C_7_C_80)
                            }
                            .lineLimit(1)
                            
                            Text("$\(data.price.removeZerosFromEnd())")
                                .font(.custom(FontContent.plusMedium, size: 11))
                                .foregroundStyle(.green)
                                .padding(.vertical,5)
                                .padding(.horizontal,10)
                                .background(.green.opacity(0.2))
                                .clipShape(.rect(cornerRadius: 15))
                                .padding(.top,25)
                            
                        }
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.E_5_E_5_EA)
                            .padding(.vertical,10)
                        
                        HStack(spacing:5){
                            Image("clock")
                                .resizable()
                                .frame(width: 18,height: 18)
                            Text("03:00 PM - 04:00 PM")
                                .font(.custom(FontContent.plusRegular, size: 12))
                                .foregroundStyle(._444446)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        HStack(spacing:5){
                            Image("calender")
                                .resizable()
                                .frame(width: 18,height: 18)
                            Text("3rd March 2024")
                                .font(.custom(FontContent.plusRegular, size: 12))
                                .foregroundStyle(._444446)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.top,5)
                    }
                    .padding([.vertical,.horizontal],12)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundStyle(.F_2_F_2_F_7)
                    }
                    .frame(width:viewWidth)
                }
            }
            .padding(.horizontal,24)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    AppointmentsView()
}
