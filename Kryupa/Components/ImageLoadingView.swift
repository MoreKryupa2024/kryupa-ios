//
//  ImageLoadingView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 03/07/24.
//

import SwiftUI

struct ImageLoadingView: View {
    
    var imageURL = String()
    
    var body: some View {
        AsyncImage(url: URL(string: imageURL),content: { image in
//            if let cachedImage = Self.cache.object(forKey: imageURL as NSString){
//                Image(uiImage: cachedImage)
//                    .resizable()
//                    .scaledToFit()
//            }else{
                
                image
                    .resizable()
                    .scaledToFill()
//                    .task {
//                        do {
//                            let _ = try await fetchImage(imageURL)
//                            print("image save")
//                        } catch { //never gets caught
//                            print("Image not saved \(error.localizedDescription)")
//                        }
//                    }
//            }
        },placeholder: {
            Image("placeholderImage")
                .resizable()
                .scaledToFit()
                .padding()
        })
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(.gray.opacity(0.3))
    }
}

#Preview {
    ImageLoadingView()
}
