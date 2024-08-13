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
                    ForEach(Array(viewModel.jobPost.enumerated()),id: \.element.jobID) {
                        (index,data) in
                        JobCell(jobPostData: data)
                            .asButton(.press) {
                                router.showScreen(.push) { rout in
                                    JobDetailView(viewModel:viewModel, jobID: data.jobID)
                                }
                            }
//                            .onAppear{
//                                if (viewModel.jobPost.count - 1) == index && viewModel.pagination{
//                                    viewModel.pageNumber += 1
//                                    viewModel.getJobsList()
//                                }
//                            }
                    }
                }
                .padding(.top, 24)
            }
            .onAppear{
                viewModel.pageNumber = 1
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
