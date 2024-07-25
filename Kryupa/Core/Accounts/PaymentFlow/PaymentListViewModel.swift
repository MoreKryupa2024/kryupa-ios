//
//  PaymentListViewModel.swift
//  Kryupa
//
//  Created by Pooja Nenava on 11/06/24.
//

import Foundation

class PaymentListViewModel: ObservableObject{
    
    @Published var paymentMethodSelected = 0
    @Published var paymentMethodList = [0,1,2]

}
