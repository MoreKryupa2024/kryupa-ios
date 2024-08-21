//
//  LoadingView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 20/08/24.
//

import SwiftUI

struct LoadingView:View{
    var body: some View{
        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea()
                .opacity(0.5)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(2)
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .onTapGesture {
            print("No access!")
        }
    }
}
