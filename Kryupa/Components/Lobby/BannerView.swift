//
//  BannerView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 28/05/24.
//

import SwiftUI

struct BannerView: View {
    
    var colors:[Color] = [.D_1_D_1_D_6,.D_1_D_1_D_6,.gray,.D_1_D_1_D_6,.gray]
    @State private var isSelectedView = 0
    var showIndecator: Bool = true
    var bannerHeight: CGFloat = 180
    
    var body: some View {
        VStack{
            TabView(selection:$isSelectedView){
                ForEach(colors.indices, id: \.self) { index in
                    ZStack{
                        colors[index.id]
                            .cornerRadius(10)
                        Text("Slider\nBanner")
                            .font(.custom(FontContent.plusMedium, size: 20))
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: bannerHeight)
            
            if showIndecator{
                HStack{
                    ForEach(colors.indices, id: \.self) { index in
                        Circle()
                            .frame(height: 6)
                            .foregroundStyle(isSelectedView == index.id ? .D_1_D_1_D_6 : .appMain)
                    }
                }
            }
        }
    }
}

#Preview {
    BannerView()
}
