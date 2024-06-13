//
//  AboutUsView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 13/06/24.
//

import SwiftUI

struct AboutUsView: View {
    @State var arrAboutUs: [AboutUsData] = [
        AboutUsData(title: "Founder’s Note", desc: "Lorem ipsum dolor sit amet consectetur. Convallis a lobortis lectus augue cursus in diam. Vitae non egestas sed nulla sem cras ut. Arcu tellus erat duis integer vitae orci. Faucibus lacus id enim lorem sit. Commodo sed neque neque montes ridiculus."),
        AboutUsData(title: "Our Journey", desc: "Lorem ipsum dolor sit amet consectetur. Convallis a lobortis lectus augue cursus in diam. Vitae non egestas sed nulla sem cras ut. Arcu tellus erat duis integer vitae orci. Faucibus lacus id enim lorem sit. Commodo sed neque neque montes ridiculus."),
        AboutUsData(title: "Mission & Vision", desc: "Lorem ipsum dolor sit amet consectetur. Convallis a lobortis lectus augue cursus in diam. Vitae non egestas sed nulla sem cras ut. Arcu tellus erat duis integer vitae orci. Faucibus lacus id enim lorem sit. Commodo sed neque neque montes ridiculus."),
        AboutUsData(title: "Terms & Conditions", desc: "Lorem ipsum dolor sit amet consectetur. Convallis a lobortis lectus augue cursus in diam. Vitae non egestas sed nulla sem cras ut. Arcu tellus erat duis integer vitae orci. Faucibus lacus id enim lorem sit. Commodo sed neque neque montes ridiculus.")

    ]
    
    @State var arrBulletList = [
        AboutUsData(title: "Lorem ipsum dolor sit amet consectetur. Convallis a lobortis lectus augue cursus in diam.", desc: ""),
        AboutUsData(title: "Vitae non egestas sed nulla sem cras ut. Arcu tellus erat duis integer vitae orci.", desc: ""),
        AboutUsData(title: "Faucibus lacus id enim lorem sit.", desc: ""),
        AboutUsData(title: "Commodo sed neque neque montes ridiculus.", desc: ""),
        AboutUsData(title: "Commodo sed neque neque montes ridiculus.", desc: ""),
        AboutUsData(title: "Lorem ipsum dolor sit amet consectetur. Convallis a lobortis lectus augue cursus in diam.", desc: "")
    ]

    var body: some View {
        VStack {
            HeaderView(title: "About Caregiver")
            ScrollView {
//                LazyVStack(spacing: 20) {
                    ForEach(Array(arrAboutUs.enumerated()), id: \.offset) { index, model in
                        getParaView(title: model.title, desc: model.desc)
                    }
                    ForEach(Array(arrBulletList.enumerated()), id: \.offset) { index, model in
                        getBulletPointList(text: model.title)
                    }
//                }
            }
            .scrollIndicators(.hidden)
            .padding(.horizontal, 25)
        }
    }
    
    func getBulletPointList(text :String) -> some View {
        HStack(alignment: .top) {
            Text("•") // Unicode bullet point character
                .fontWeight(.semibold)

            Text(text)
                .font(.custom(FontContent.plusRegular, size: 13))
                .foregroundStyle(._444446)

            Spacer()
        }
        .padding(.leading)
        .padding(.vertical, 5)
    }
    
    func getParaView(title: String, desc: String) -> some View{
        
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.custom(FontContent.besMedium, size: 16))
                .foregroundStyle(._242426)
            
            Text(desc)
                .font(.custom(FontContent.plusRegular, size: 13))
                .foregroundStyle(._444446)
        }
        .padding(.vertical, 15)
    }
}

struct AboutUsData {
    let title: String
    let desc: String
}

#Preview {
    AboutUsView()
}
