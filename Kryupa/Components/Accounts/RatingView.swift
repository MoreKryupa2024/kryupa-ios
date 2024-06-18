//
//  RatingView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 17/06/24.
//

import SwiftUI

struct RatingView: View {
    
    @State var starList = [false, false, false, false, false]
    @State var selected = false

    var body: some View {
        HStack {
            ForEach(Array(starList.enumerated()), id: \.offset) { index, model in
                Image(model ? "star" : "star_unselected")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .asButton(.press) {
                        for (indexS,value) in starList.enumerated() {
                            if indexS <= index {
                                starList.remove(at: indexS)
                                starList.insert(true, at: indexS)
                            }
                            if indexS > index {
                                starList.remove(at: indexS)
                                starList.insert(false, at: indexS)
                            }
                        }
                        selected.toggle()
                    }
            }
            Spacer()
        }
    }
}

#Preview {
    RatingView()
}
