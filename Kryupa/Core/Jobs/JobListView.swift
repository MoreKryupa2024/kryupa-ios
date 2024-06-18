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
                                JobDetailView(job: JobPost(customerInfo: CustomerInfo(name: "Alex Chatterjee", gender: "Male", price: "40.0", diseaseType: ["Diabetes", "Kidney Stone"]), bookingDetails: BookingDetails(areaOfExpertise: ["Nursing", "Bathing", "House Cleaning","Doing Chores and more"], bookingType: "One Time", startDate: "2024-06-14", endDate: "2024-06-14", startTime: "09:45:18", endTime: "00:40:22"), jobID: "f9bdf7df-103e-41b9-a95e-560b85c5bde1"))
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
