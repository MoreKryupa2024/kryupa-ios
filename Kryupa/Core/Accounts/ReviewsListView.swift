//
//  ReviewsListView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 12/06/24.
//

import SwiftUI

struct ReviewsListView: View {
    @State var selectedSection = 0
    
    var body: some View {
        
        ScrollView {
            HeaderView
            SegmentView
            
            if selectedSection == 0 {
                LazyVStack(spacing: 15) {
                    ForEach(0...3) {
                        msg in
                        
                        ReviewCell()
                    }
                }
                .padding(.top, 20)
            }
            else {
                LazyVStack(spacing: 15) {
                    ForEach(0...1) {
                        msg in
                        
                        ReviewCell()
                    }
                }
                .padding(.top, 20)
            }
        }
    }
    
    private var SegmentView: some View{
        
        Picker("Reviews", selection: $selectedSection) {
            Text("My Reviews")
                .tag(0)
                .font(.custom(FontContent.plusRegular, size: 12))
            
            Text("Reviews Given")
                .tag(1)
                .font(.custom(FontContent.plusRegular, size: 12))
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 24)
        .padding(.top, 20)
        
    }
    
    private var HeaderView: some View{
        
        VStack(spacing: 24) {
            ZStack{
                Image("KryupaLobby")
                    .resizable()
                    .frame(width: 124,height: 20)
                
                HStack{
                    Image("navBack")
                        .resizable()
                        .frame(width: 30,height: 30)
                        .asButton(.press) {
                        }
                    Spacer()
                    Image("NotificationBellIcon")
                        .frame(width: 25,height: 25)
                }
                .padding(.horizontal,24)
            }
        }
        
    }
}

#Preview {
    ReviewsListView()
}
