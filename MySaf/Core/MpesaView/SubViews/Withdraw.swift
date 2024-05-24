//
//  WithdrawView.swift
//  MySaf
//
//  Created by Muktar Hussein on 17/05/2024.
//

import SwiftUI

struct Withdraw: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var mpesaBalance = MpesaBalance.instance
    @Environment(\.dismiss) var dismiss
    
    @State private var agentNumber: String = ""
    @State private var storeNumber: String = ""
    @State private var amount: Double = 0.0
    @State private var showAgentDetails: Bool = false
    @State private var agentDetailsMatch: Bool = false
    @State private var isLoading: Bool = false
    @State private var successfulAuth: Bool = false
    @State private var usePin: Bool = false
    @State private var hakikishaAlert: Bool = true
    let transactionType: TransactionType = .withdraw
    
    let mockStoreNumber: String = "0000"
    
    
    // compute transaction cost
    var transactionCost: Double {
        if amount < 49 && amount <= 100 {
            return 11
        } else if amount > 100 && amount <= 2500 {
            return 29
        } else if amount > 2500 && amount <= 3500 {
            return 52
        } else if amount > 3500 && amount <= 5000 {
            return 69
        } else if amount > 5000 && amount <= 7500 {
            return 87
        } else if amount > 7500 && amount <= 10_000 {
            return 115
        } else if amount > 10_000 && amount <= 15_000 {
            return 167
        } else if amount > 15_000 && amount <= 20_000 {
            return 185
        }
        return 0.0
    }
    
    
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ZStack {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Favorite Agents")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        
                        HStack {
                            VStack {
                                Image(systemName: "star")
                                    .foregroundStyle(.green)
                                    .padding(8)
                                    .overlay {
                                        Circle()
                                            .fill(.green.opacity(0.3))
                                    }
                                
                                Text("Add New")
                            }
                            Text("Save your favorite agents for quick transactions. Just tap on the star to add")
                            
                        }
                        .foregroundStyle(.green)
                        .font(.subheadline)
                        
                        // MARK: Text fields
                        TextField("Enter Agent Number.", text: $agentNumber)
                            .keyboardType(.numberPad)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                        
                        TextField("Enter Store Number.", text: $storeNumber)
                            .keyboardType(.numberPad)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                        
                        TextField("Enter Amount (min: 50).", value: $amount, format: .number)
                            .keyboardType(.numberPad)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                        
                        
                        // MARK: Continue button
                        Text("Continue")
                            .foregroundStyle(.white)
                            .font(.headline)
                            .fontWeight(.medium)
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                            .background {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(agentNumber.count < 4 || storeNumber.count < 4 ? .gray : .green)
                            }
                            .onTapGesture {
                                guard agentNumber.count >= 4 || storeNumber.count >= 4 else { return }
                                withAnimation(.easeIn) {
                                    isLoading = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    if storeNumber == mockStoreNumber {
                                        withAnimation(.easeIn) {
                                            agentDetailsMatch = true
                                            showAgentDetails = false
                                        }
                                        isLoading = false
                                        return
                                    }
                                    
                                    withAnimation(.easeOut) {
                                        isLoading = false
                                    }
                                    
                                    withAnimation(.easeIn) {
                                        showAgentDetails = true
                                    }
                                }
                            }
                        
                        Spacer()
                        
                        
                    }
                    .padding(10)
                    .navigationTitle("Withdraw Cash")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitleTextColor(.white)
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
                    .blur(radius: isLoading || showAgentDetails || agentDetailsMatch ? 5 : 0)
                    .navigationDestination(isPresented: $successfulAuth) {
                        SentView(
                            amount: amount,
                            phoneNumber: "",
                            transactionCost: transactionCost,
                            randomID: RandomID.shared.randomString(),
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
                }
                
                VStack {
                    if isLoading {
                        ProgressView()
                            .scaleEffect(CGSize(width: 1.4, height: 1.4))
                            .tint(.green)
                    }
                    
                    if showAgentDetails {
                        PopUp(
                            popUse: "Agent Name:",
                            popName: "Hello World",
                            grayButton: "CANCEL",
                            greenButton: "WITHDRAW",
                            cancel: $showAgentDetails,
                            hakikishaAlert: $hakikishaAlert, 
                            amount: amount,
                            transactionCost: transactionCost,
                            greenButtonAction: withdrawHandler
                        )
                    }
                    
                    if agentDetailsMatch {
                        ErrorAnimation(
                            dismiss: $agentDetailsMatch,
                            startAnimation: true
                        )
                    }
                    
                }
                .offset(y: 200)
                
                
                Rectangle()
                    .fill(colorScheme == .light ? .green : Color("buttonColor"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 93)
                    .ignoresSafeArea()
                
            }
        }
    }
    
    func withdrawHandler() {
        guard agentNumber.count >= 4 && storeNumber.count >= 4 else { return }
        Task {
            let success = await LocalAuth.shared.authenticateWithBiometrics(reason: "Biometrics needed for airtime purchase")
            if success {
                mpesaBalance.deductAmount(amount: amount, transaction: transactionCost)
                withAnimation(.easeIn) {
                    successfulAuth.toggle()
                }
            } else {
                usePin.toggle()
            }
        }
    }
}

#Preview {
    Withdraw()
}
