//
//  JobListView.swift
//  Kryupa
//
//  Created by Pooja Nenava on 17/06/24.
//

import SwiftUI

struct JobListView: View {
    @Environment(\.router) var router
    @StateObject var viewModel = JobsViewModel()
    
    var body: some View {
        ZStack{
            ScrollView {
                HeaderView()
                LazyVStack(spacing: 15) {
                    ForEach(viewModel.jobPost,id: \.jobID) {
                        data in
                        JobCell(jobPostData: data)
                            .asButton(.press) {
                                router.showScreen(.push) { rout in
                                    JobDetailView(viewModel:viewModel, jobID: data.jobID)
                                }
                            }
                    }
                }
                .padding(.top, 24)
            }
            .onAppear{
                viewModel.getJobsList()
            }
            
            if viewModel.isloading{
                LoadingView()
            }
        }
    }
}

#Preview {
    JobListView()
}
