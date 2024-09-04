//
//  BannerView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 28/05/24.
//

import SwiftUI
import SwiftfulUI
struct BannerView: View {
    
    var banners:[BannerDataModel] = []
    var assetsImage:[String] = []
    var nameList:[String] = []
    @State private var isSelectedView = 0
    var showIndecator: Bool = true
    var fromAssets: Bool = true
    var aspectRatio: CGFloat = 327/58
    var onSelect:((Int)->Void)? = nil
    
    var body: some View {
        VStack{
            TabView(selection:$isSelectedView){
                if fromAssets{
                    ForEach(assetsImage.indices, id: \.self) { index in
                        ZStack(alignment: .leading){
                            Image(assetsImage[index])
                                .resizable()
                                
                            if nameList.count == assetsImage.count{
                                VStack(alignment:.leading,spacing:4){
                                    Text("\(nameList[index]) has arrived to your location?")
                                        .font(.custom(FontContent.plusMedium, size: 13))
                                    
                                    Text("Confirm")
                                        .padding(.vertical,6)
                                        .padding(.horizontal,9)
                                        .foregroundStyle(.white)
                                        .font(.custom(FontContent.plusRegular, size: 11))
                                        .background(
                                            RoundedRectangle(cornerRadius: 3)
                                                .foregroundStyle(.FF_8112)
                                        )
                                }
                                .padding(.leading,14)
                                .padding(.vertical,8)
                            }
                        }
                        .padding(.horizontal, 24)
                        .asButton {
                            onSelect?(index)
                        }
                    }
                }else{
                    ForEach(banners.indices, id: \.self) { index in
                        ImageLoadingView(imageURL: banners[index].bannerURL)
                            .padding(.horizontal, 24)
                            .asButton {
                                onSelect?(index)
                            }
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
                                .foregroundStyle(isSelectedView != index.id ? .D_1_D_1_D_6 : .appMain)
                        }
                    }else{
                        ForEach(banners.indices, id: \.self) { index in
                            Circle()
                                .frame(height: 6)
                                .foregroundStyle(isSelectedView != index.id ? .D_1_D_1_D_6 : .appMain)
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
