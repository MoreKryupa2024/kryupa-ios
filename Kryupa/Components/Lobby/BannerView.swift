//
//  BannerView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 28/05/24.
//

import SwiftUI

struct BannerView: View {
    
    var banners:[BannerDataModel] = []
    var assetsImage:[String] = ["customer home top","customer home top 2"]
    @State private var isSelectedView = 0
    var showIndecator: Bool = true
    var fromAssets: Bool = false
    var aspectRatio: CGFloat = 327/58
    
    var body: some View {
        VStack{
            TabView(selection:$isSelectedView){
                if fromAssets{
                    ForEach(assetsImage.indices, id: \.self) { index in
                        Image(assetsImage[index])
                            .resizable()
                    }
                }else{
                    ForEach(banners.indices, id: \.self) { index in
                        ImageLoadingView(imageURL: banners[index].bannerURL)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .aspectRatio(aspectRatio, contentMode: .fit)
            
            if showIndecator{
                HStack{
                    if fromAssets{
                        ForEach(assetsImage.indices, id: \.self) { index in
                            Circle()
                                .frame(height: 6)
                                .foregroundStyle(isSelectedView == index.id ? .D_1_D_1_D_6 : .appMain)
                        }
                    }else{
                        ForEach(banners.indices, id: \.self) { index in
                            Circle()
                                .frame(height: 6)
                                .foregroundStyle(isSelectedView == index.id ? .D_1_D_1_D_6 : .appMain)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BannerView()
}
