//
//  GiveReviewView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 17/06/24.
//

import SwiftUI

struct GiveReviewView: View {
    
    @State var isEditAddress = false
    @State var isEditReview = false
    @State var txtReview = ""

    var body: some View {
        ScrollView {
            HeaderView(showBackButton: true)
            UserView
            DateTimeView
            line
            AddressView
            line
            ReviewHoursView()
            line
            WriteReview
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var WriteReview: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                HStack {
                    Text("Review:")
                        .font(.custom(FontContent.plusRegular, size: 17))
                        .foregroundStyle(.appMain)

                    Spacer()
                    
                    if !isEditReview {
                        Image("edit-two")
                            .frame(width: 17, height: 17)
                        
                        Text("Edit")
                            .font(.custom(FontContent.plusRegular, size: 16))
                            .foregroundStyle(._7_C_7_C_80)
                    }
                    
                }
                .asButton(.press) {
                    isEditReview = true
                }
            }

            RatingView()
                .disabled(isEditReview ? false : true)

            
            TextEditorWithPlaceholder(text: $txtReview)
                .disabled(isEditReview ? false : true)

            if isEditReview {
                Text("Submit")
                    .font(.custom(FontContent.plusRegular, size: 16))
                    .foregroundStyle(.white)
                    .frame(height: 35)
                    .frame(width: 96)
                    .background{
                        RoundedRectangle(cornerRadius: 48)
                    }
                    .asButton(.press) {
                        isEditReview = false
                    }
            }

        }
        .padding([.horizontal,.top], 24)

    }
    
    private var AddressView: some View{
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Address:")
                    .font(.custom(FontContent.plusRegular, size: 17))
                    .foregroundStyle(.appMain)
                    .disabled(isEditAddress ? false : true)


                Spacer()
                
                HStack {
                    Image("edit-two")
                        .frame(width: 17, height: 17)
                    
                    Text("Edit")
                        .font(.custom(FontContent.plusRegular, size: 16))
                        .foregroundStyle(._7_C_7_C_80)
                }
                .asButton(.press) {
                    isEditAddress = true
                }
            }
            
            Text("FG 20, Sector 54, New York\nUSA, 541236")
                .font(.custom(FontContent.plusRegular, size: 12))
                .foregroundStyle(.appMain)

        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
        
    }
    
    private var DateTimeView: some View{
        VStack(alignment: .leading) {
            HStack {
                Text("Monday, 07 March 2024")
                    .font(.custom(FontContent.besMedium, size: 16))
                    .foregroundStyle(.appMain)
                    .padding(.horizontal, 24)

                Spacer()
            }
            .padding(.top, 5)

            HStack {
                Text("02:00 PM - 05:00PM")
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(._444446)
                    .padding(.horizontal, 24)

                Spacer()
            }
            .padding(.bottom, 5)

        }
        .frame(height: 60)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .inset(by: 1)
                .stroke(.E_5_E_5_EA, lineWidth: 1)
        )
        .padding(.horizontal, 24)
        .padding(.top, 30)

    }
    
    private var line: some View {
        Divider()
            .background(.F_2_F_2_F_7)
            .padding(.top, 24)
            .padding(.trailing, 35)
            .frame(height: 2)
    }
    
    private var UserView: some View{
        VStack(spacing:2) {
            ZStack {
                
                Text("Profile")
                    .font(.custom(FontContent.besMedium, size: 20))
                    .foregroundStyle(.appMain)
                
                HStack {
                    Spacer()
                    Text("Download invoice")
                        .font(.custom(FontContent.plusRegular, size: 10))
                        .foregroundStyle(._7_C_7_C_80)
                        .underline()
                }
                .padding(.trailing, 24)
            }
            
            HStack {
                Image("giveReview")
                    .resizable()
                    .frame(width: 126, height: 126)
                    .cornerRadius(63)
            }
            .frame(width: 138, height: 138)
            .cornerRadius(69)
            .overlay(
                RoundedRectangle(cornerRadius: 69)
                    .inset(by: 1)
                    .stroke(.E_5_E_5_EA, lineWidth: 1)
            )
            
            Text("Alexa Chatterjee")
                .font(.custom(FontContent.besMedium, size: 20))
                .foregroundStyle(.appMain)
            
            Text("$214")
                .font(.custom(FontContent.plusRegular, size: 12))
                .foregroundStyle(._444446)

            HStack {
                ForEach (0...3) {_ in
                    Image("star")
                        .resizable()
                        .frame(width: 12, height: 12)
                }
                Text("(100)")
                    .font(.custom(FontContent.plusRegular, size: 11))
                    .foregroundStyle(.appMain)
            }
            
            Spacer()
            Spacer()
            
            Text("Completed")
                .padding()
                .frame(height: 31)
                .font(.custom(FontContent.plusRegular, size: 16))
                .foregroundStyle(._23_C_16_B)
                .background(
                    RoundedRectangle(cornerRadius: 12).fill(Color.E_0_FFEE)
                )
        }
    }
}

struct TextEditorWithPlaceholder: View {
     @Binding var text: String
     
     var body: some View {
         ZStack(alignment: .leading) {
             if text.isEmpty {
                VStack {
                     Text("Write a review")
                         .padding(.top, 10)
                         .padding(.leading, 6)
                         .opacity(0.6)
                     Spacer()
                 }
             }
             
             VStack {
                 TextEditor(text: $text)
                     .font(.custom(FontContent.plusRegular, size: 12))
                     .frame(minHeight: 150, maxHeight: 300)
                     .opacity(text.isEmpty ? 0.85 : 1)
                 Spacer()
             }
         }
     }
 }


#Preview {
    GiveReviewView()
}
