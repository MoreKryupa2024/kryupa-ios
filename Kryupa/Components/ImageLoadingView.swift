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
                image
                    .resizable()
                    .scaledToFill()
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
