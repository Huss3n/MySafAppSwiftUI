//
//  FulizaView.swift
//  MySaf
//
//  Created by Muktar Hussein on 22/05/2024.
//

import SwiftUI
import LocalAuthentication

struct FulizaView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var mpesaBalance = MpesaBalance.instance
    @State private var usePIN: Bool = false // <- fall back for biometrics
    var amount: Double = 0.0
    var fulizaAmount: Double = 345.57
    var phoneNumber: String
    var transactionCost: Double
    @Binding var showFulizaAlert: Bool
    @State private var successfullAuth: Bool = false
    
    var transactionType: TransactionType = .send
    
    var randomID: String {
        return RandomID.shared.randomString()
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(colorScheme == .light ? .white : Color("buttonColor"))
                    .shadow(radius: 4)
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .padding(.horizontal, 10)
                    .overlay {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Send Money")
                                .font(.headline)
                                .foregroundStyle(.green)
                            
                            Rectangle()
                                .frame(maxWidth: .infinity)
                                .frame(height: 1.0)
                            
                            Group {
                                Text("You have Insufficient Funds on M-PESA. You are about to Fuliza ") +
                                Text("Ksh. \(String(format: "%.2f", fulizaAmount))").foregroundStyle(.green).font(.headline) +
                                Text(" to complete this transaction")
                            }
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            
                            HStack(spacing: 4) {
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(.gray)
                                    .frame(width: 120, height: 30)
                                    .overlay {
                                        Text("CANCEL")
                                            .foregroundStyle(.black)
                                            .onTapGesture {
                                                withAnimation(.bouncy) {
                                                    showFulizaAlert.toggle()
                                                }
                                            }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                RoundedRectangle(cornerRadius: 25.0)
                                    .fill(.green)
                                    .frame(width: 120, height: 30)
                                    .overlay {
                                        Text("CONTINUE")
                                            .foregroundStyle(.black)
                                            .onTapGesture {
                                                Task.init {
                                                    var success = await verifyUser()
                                                    if success {
                                                        // update the balance
                                                        MpesaBalance.instance.deductAmount(amount: amount, transaction: fulizaAmount)
                                                        withAnimation(.easeIn) {
                                                            successfullAuth = true
                                                        }
                                                    } else {
                                                        // fall back to pin
                                                        withAnimation(.bouncy) {
                                                            usePIN = true
                                                        }
                                                    }
                                                }
                                            }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding()
                        .padding(.horizontal, 12)
                    }
            }
            .navigationDestination(isPresented: $successfullAuth) {
                SentView(
                    amount: amount,
                    phoneNumber: phoneNumber,
                    transactionCost: transactionCost,
                    randomID: randomID,
                    transactionType: transactionType
                )
                .navigationBarBackButtonHidden(true)
            }
            .sheet(isPresented: $usePIN, content: {
                PinView(amount: fulizaAmount) { success in
                    if success {
                        // deduct amount
                        mpesaBalance.deductAmount(amount: fulizaAmount, transaction: transactionCost)
                        withAnimation(.easeIn) {
                            successfullAuth  = true
                        }
                    }
                }
            })
        }
            
    }
    
    // MARK: Functions
    func verifyUser() async -> Bool {
        return await LocalAuth.shared.authenticateWithBiometrics(reason: "FaceID needed for transaction")
    }
}

#Preview {
    FulizaView(phoneNumber: "0712345678", transactionCost: 300, showFulizaAlert: .constant(true))
}
