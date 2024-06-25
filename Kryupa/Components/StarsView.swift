//
//  StarsView.swift
//  Kryupa
//
//  Created by Hemant Singh Rajput on 21/06/24.
//

import SwiftUI

struct StarsView: View {
    var rating: Double = 0.0
    var maxRating: Int = 5
    var size: CGFloat = 12

    var body: some View {
        let stars = HStack(spacing: 3) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size,height: size)
            }
        }

        stars.overlay(
            GeometryReader { g in
                let width = rating / CGFloat(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.appMain)
                }
            }
            .mask(stars)
        )
        .foregroundColor(.gray)
    }
}


#Preview {
    StarsView()
}
