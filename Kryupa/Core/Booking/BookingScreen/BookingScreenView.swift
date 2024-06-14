//
//  BookingScreenView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 14/06/24.
//

import SwiftUI

struct BookingScreenView: View {
    
    @State var selectedSection = 0
    
    var body: some View {
        ZStack{
            VStack{
                HeaderView()
                SegmentView
                    .padding(.bottom,20)
                ScrollView{
                    switch selectedSection{
                    case 0:
                        ForEach(1...5) { index in
                            BookingView(status: "Active")
                        }
                    case 1:
                        ForEach(1...3) { index in
                            BookingView(status: "Completed")
                        }
                    case 2:
                        ForEach(1...1) { index in
                            BookingView(status: "Cancelled")
                        }
                            
                    default:
                        EmptyView()
                    }
                    
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
    
    private var SegmentView: some View{
        
        Picker("Booking", selection: $selectedSection) {
            Text("Active")
                .tag(0)
                .font(.custom(FontContent.plusRegular, size: 12))

            Text("Completed")
                .tag(1)
                .font(.custom(FontContent.plusRegular, size: 12))
            
            Text("Cancelled")
                .tag(2)
                .font(.custom(FontContent.plusRegular, size: 12))
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 24)
        .padding(.top, 20)
        
    }
}

#Preview {
    BookingScreenView()
}
