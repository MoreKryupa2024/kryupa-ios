//
//  CardListScreenView.swift
//  Kryupa
//
//  Created by Nirmal Singh Rajput on 20/11/24.
//

import SwiftUI
import SwiftfulUI

struct CardListScreenView: View {
    
    @StateObject var viewPaymentViewModel = PaymentViewModel()
    @StateObject var viewModel = AddCardStripeScreenViewModel()
    @Environment(\.router) var router
    @State var showAddCardScreen = false
    var moneyAddedAction: (()->Void)? = nil
    var backAction: (()->Void)? = nil
    private let defaults = Defaults()
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HeaderViewWithRouter(title: "Stripe Card List", showBackButton: true) {
                    backAction?()
                }
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(viewModel.stripeCardList, id: \.id) { data in
                            cardView(stripeCardListData: data)
                                .asButton(.press) {
                                    viewModel.stripeCharge(paymentMethodId: data.paymentmethodid, stripeCustomerId: data.stripecustomerid, amount: viewPaymentViewModel.amount)
                                }
                        }
                        addCardButton
                    }
                    .padding(.top, 30)
                }
            }
            .onAppear{
                viewModel.getCardList()
            }
            .onChange(of: viewModel.amountAdded) { oldValue, newValue in
                if viewModel.amountAdded{
                    moneyAddedAction?()
                }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
            
            if showAddCardScreen{
                AddCardStripeScreenView(viewPaymentViewModel: viewPaymentViewModel) {
                    moneyAddedAction?()
                } backAction: {
                    showAddCardScreen = false
                }
                .background(.white)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }

    // MARK: - Add Card Button View
    private var addCardButton: some View {
        HStack(spacing: 20) {
            Text("Add new card")
                .font(.custom(FontContent.plusRegular, size: 15))
                .padding(.leading, 28)
            Spacer()
            Image("chevron-right")
                .resizable()
                .frame(width: 21, height: 25)
                .padding(.trailing, 28)
        }
        .frame(height: 48)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(lineWidth: 1.0)
                .foregroundStyle(.E_5_E_5_EA)
        )
        .padding([.horizontal, .top], 24)
        .asButton(.press) {
            showAddCardScreen = true
        }
    }

    // MARK: - Card View
    private func cardView(stripeCardListData:StripeCardListData)-> some View {
        return    ZStack {
                RoundedRectangle(cornerRadius: 17)
                    .foregroundStyle(.F_2_F_2_F_7)
                    .overlay {
                        Text("**** **** **** \(stripeCardListData.lastfour)")
                            .font(.custom(FontContent.plusMedium, size: 22))
                            .foregroundStyle(.black)
                            .padding(.leading, 20)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .offset(y: -15)
                    }
                    .frame(height: 164)
                    .padding(.horizontal, 24)

                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 0)
                        .cornerRadius(17, corners: [.bottomLeft, .bottomRight])
                        .overlay {
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text("Card holder name")
                                        .font(.custom(FontContent.plusRegular, size: 10))
                                    Text("\(defaults.firstName) \(defaults.lastName)")
                                        .font(.custom(FontContent.plusMedium, size: 13))
                                }
                                .foregroundStyle(.white)
                                .padding(.leading, 20)

                                Spacer()

                                Image("DeleteButton")
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing, 15)
                                    .asButton(.press) {
                                        viewModel.deleteCard(stripeCardListData: stripeCardListData)
                                    }
                            }
                        }
                        .foregroundStyle(.black)
                        .frame(height: 63)
                        .padding(.horizontal, 24)
                }
            }
        
    }
}

#Preview {
    CardListScreenView()
}
