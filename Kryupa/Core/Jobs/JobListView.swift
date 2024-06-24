//
//  JobListView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 17/06/24.
//

import SwiftUI

struct JobListView: View {
    @Environment(\.router) var router

    var body: some View {
        ScrollView {
            HeaderView()
            LazyVStack(spacing: 15) {
                ForEach(0...5) {
                    _ in
                    
                    JobCell()
                        .asButton(.press) {
                            router.showScreen(.push) { rout in
                                JobDetailView(job: JobPost(jsonData: [String : Any]()))
                            }
                        }
                }
            }
            .padding(.top, 24)
        }
    }
}

#Preview {
    JobListView()
}
