//
//  ReviewsListView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 12/06/24.
//

import SwiftUI
import SwiftfulUI

struct ReviewsListView: View {
    @State var selectedSection = 0
    @Environment(\.router) var router
    
    var body: some View {
        
        ScrollView {
            HeaderView(showBackButton: true)
            SegmentView
            
            if selectedSection == 0 {
                LazyVStack(spacing: 15) {
                    ForEach(0...3) {
                        msg in
                        
                        ReviewCell()
                            .asButton(.press) {
                                router.showScreen(.push) { rout in
                                    ReviewDetailView()
                                }
                            }
                    }
                }
                .padding(.top, 20)
            }
            else {
                LazyVStack(spacing: 15) {
                    ForEach(0...1) {
                        msg in
                        
                        ReviewCell()
                            .asButton(.press) {
                                router.showScreen(.push) { rout in
                                    ReviewDetailView()
                                }
                            }
                    }
                }
                .padding(.top, 20)
            }
        }
        .scrollIndicators(.hidden)
        .toolbar(.hidden, for: .navigationBar)
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
}

#Preview {
    ReviewsListView()
}
