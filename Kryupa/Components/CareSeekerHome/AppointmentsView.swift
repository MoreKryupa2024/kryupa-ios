//
//  AppointmentsView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 12/06/24.
//

import SwiftUI
import SwiftfulUI

struct AppointmentsView: View {
    
    var appointmentList: [BookingsListData] = [BookingsListData]()
    let viewWidth:CGFloat = CGFloat((UIScreen.screenWidth - (50)))
    var selecatedAction:((BookingsListData)->Void)
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing:10){
                ForEach(appointmentList,id: \.id) { data in
                    
                    VStack(spacing:0){
                        HStack(spacing:15){
                            
                            ImageLoadingView(imageURL: data.profilePictureURL)
                                .frame(width: 50,height: 50)
                                .clipShape(.rect(cornerRadius: 25))
                                .clipped()
                            VStack(alignment:.leading, spacing:0){
                                Text(data.name)
                                    .font(.custom(FontContent.besMedium, size: 17))
                                    .frame(maxWidth:.infinity,alignment: .leading)
                                Text("For \(data.relation)")
                                    .font(.custom(FontContent.plusRegular, size: 13))
                                    .foregroundStyle(._7_C_7_C_80)
                            }
                            .lineLimit(1)
                            
                            Text("$\(data.price.removeZerosFromEnd())")
                                .font(.custom(FontContent.plusMedium, size: 13))
                                .foregroundStyle(data.status != "Job Cancelled" ? .green : .red)
                                .padding(.vertical,5)
                                .padding(.horizontal,10)
                                .background(data.status != "Job Cancelled" ? .green.opacity(0.2) : .red.opacity(0.2))
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
                                .frame(width: 22,height: 22)
                            Text("\(data.startTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a")) - \(data.endTime.convertDateFormater(beforeFormat: "HH:mm:ss", afterFormat: "h:mm a"))")
                                .font(.custom(FontContent.plusRegular, size: 15))
                                .foregroundStyle(._444446)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        HStack(spacing:5){
                            Image("calender")
                                .resizable()
                                .frame(width: 22,height: 22)
                            
                            Text("\(data.startDate.convertDateFormater(beforeFormat: "YYYY-MM-dd", afterFormat: "dd MMM yyyy"))")
                                .font(.custom(FontContent.plusRegular, size: 15))
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
                    .asButton(.press) {
                        selecatedAction(data)
                    }
                }
            }
            .padding(.horizontal,24)
        }
        .scrollIndicators(.hidden)
    }
}
