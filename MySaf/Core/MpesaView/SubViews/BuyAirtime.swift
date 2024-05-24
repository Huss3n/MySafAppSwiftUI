//
//  BuyAirtime.swift
//  MySaf
//
//  Created by Muktar Hussein on 23/05/2024.
//

import SwiftUI

struct BuyAirtime: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var mpesaBalance = MpesaBalance.instance
    @State private var activeState: Bool = true
    @State private var phoneNumber: String = ""
    @State private var amount: Double = 0
    @Environment(\.dismiss) var dismiss
    @State private var hakikishaAlert: Bool = true
    @State private var isLoading: Bool = false
    @State private var completeTransaction: Bool = false
    @State private var successfulAuth: Bool = false
    @State private var usePin: Bool = false
    
    let transactionCost: Double = 0.0
    

    var randomID: String {
        return RandomID.shared.randomString()
    }
    
    let transactionType: TransactionType = .airtime
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                VStack(spacing: 16) {
                    Text("Top Up")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // MARK: Radio buttons
                    HStack(spacing: 10) {
                        Circle()
                            .fill(activeState ? .green : .clear)
                            .stroke(activeState ? .green : .primary, lineWidth: 2.0)
                            .frame(width: 15, height: 15)
                            .onTapGesture {
                                withAnimation(.bouncy) {
                                    activeState.toggle()
                                }
                            }
                        Text("My Number")
                        
                        Spacer()
                        
                        Circle()
                            .fill(!activeState ? .green : .clear)
                            .stroke(!activeState ? .green : .primary, lineWidth: 2.0)
                            .frame(width: 15, height: 15)
                            .onTapGesture {
                                withAnimation(.bouncy) {
                                    activeState.toggle()
                                }
                            }
                        Text("Other Number")
                    }
                    .fontWeight(.light)
                    .padding(.trailing, 30)
                    
                    // MARK: Textfields
                    if !activeState {
                        TextField("Enter Recipient's No..", text: $phoneNumber)
                            .keyboardType(.numberPad)
                            .padding(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                    }
                    
                    TextField("Enter Amount.", value: $amount, format: .number)
                        .keyboardType(.numberPad)
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 0.5)
                        }
                    
                    ScrollView(.horizontal) {
                        HStack {
                            Capsule()
                                .stroke(Color.green, lineWidth: 1.5)
                                .frame(width: 70, height: 40)
                                .overlay {
                                    Text("\(20)")
                                }
                                .onTapGesture {
                                    amount = 20
                                }
                            
                            
                            
                            Capsule()
                                .stroke(Color.green, lineWidth: 1.5)
                                .frame(width: 70, height: 40)
                                .overlay {
                                    Text("\(50)")
                                }
                                .onTapGesture {
                                    amount = 50
                                }
                            
                            Capsule()
                                .stroke(Color.green, lineWidth: 1.5)
                                .frame(width: 70, height: 40)
                                .overlay {
                                    Text("\(100)")
                                }
                                .onTapGesture {
                                    amount = 100
                                }
                            
                            
                            Capsule()
                                .stroke(Color.green, lineWidth: 1.5)
                                .frame(width: 70, height: 40)
                                .overlay {
                                    Text("\(200)")
                                }
                                .onTapGesture {
                                    amount = 200
                                }
                            
                            
                            Capsule()
                                .stroke(Color.green, lineWidth: 1.5)
                                .frame(width: 70, height: 40)
                                .overlay {
                                    Text("\(500)")
                                }
                                .onTapGesture {
                                    amount = 500
                                }
                            
                            
                            Capsule()
                                .stroke(Color.green, lineWidth: 1.7)
                                .frame(width: 80, height: 40)
                                .overlay {
                                    Text("\(1000)")
                                }
                                .onTapGesture {
                                    amount = 1000
                                }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    Text("TOP UP")
                        .foregroundStyle(.white)
                        .font(.headline)
                        .fontWeight(.medium)
                        .frame(height: 45)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 25)
                                .fill(amount == 0 ? .gray : .green)
                        }
                        .onTapGesture {
//                            guard amount == 0 else { return }
                            isLoading = true
                            
                            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2.0) {
                                isLoading = false
                                withAnimation(.easeIn) {
                                    completeTransaction = true
                                }
                            }
                        }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 18)
                .navigationTitle("Buy Airtime")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Image(systemName: "arrow.left")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .onTapGesture {
                                dismiss()
                            }
                    }
                }
                .navigationBarTitleTextColor(.white)
                .blur(radius: isLoading || completeTransaction ? 5 : 0)
                .navigationDestination(isPresented: $successfulAuth) {
                    SentView(
                        amount: amount,
                        phoneNumber: phoneNumber,
                        transactionCost: transactionCost,
                        randomID: randomID,
                        transactionType: transactionType
                    )
                    .navigationBarBackButtonHidden()
                }
                .sheet(isPresented: $usePin) {
                    PinView(
                        amount: amount,
                        showTransactionText: true,
                        login: { success in
                            if success {
                                successfulAuth.toggle()
                            }
                        }
                    )
                }
                
                VStack {
                    if isLoading {
                        ProgressView()
                            .scaleEffect(CGSize(width: 1.4, height: 1.4))
                            .tint(.green)
                    }
                    
                    if completeTransaction {
                        PopUp(
                            popUse: "Buy Airtime For",
                            popName: "My Number",
                            grayButton: "CANCEL",
                            greenButton: "BUY",
                            cancel: $completeTransaction,
                            hakikishaAlert: $hakikishaAlert,
                            amount: amount, 
                            transactionCost: transactionCost,
                            greenButtonAction: airtimeHandler
                        )
                    }
                }
                .offset(y: 150)
                
                Rectangle()
                    .fill(colorScheme == .light ? .green : Color("buttonColor"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 93)
                    .ignoresSafeArea()
            }
        }
    }
    
    func airtimeHandler()  {
        guard amount > 0 else { return }
        Task {
            let success = await LocalAuth.shared.authenticateWithBiometrics(reason: "Biometrics needed for airtime purchase")
            
            if success {
                mpesaBalance.deductAmount(amount: amount, transaction: transactionCost)
                withAnimation(.easeIn) {
                    successfulAuth.toggle()
                }
            }
        }
    }
}

#Preview {
    BuyAirtime()
}


