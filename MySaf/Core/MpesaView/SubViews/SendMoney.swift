//
//  SendMoneyView.swift
//  MySaf
//
//  Created by Muktar Hussein on 17/05/2024.
//

import SwiftUI
import LocalAuthentication

struct SendMoney: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var mpesaBalance = MpesaBalance.instance
    @State private var phoneNumber: String = ""
    @State private var amount: Double = 0.0
    @Environment(\.dismiss) var dismiss
    @State private var sendTo: Bool = false
    @State private var ownnNumber: Bool = false
    @State private var isLoading: Bool = false
    @State private var successfulAuth: Bool = false
    @State private var phoneNumberLimit: Int = 10
    @State private var usePin: Bool = false    
    @State private var hakikishaAlert: Bool = false
    let transactionType: TransactionType = .send
    
    var randomID: String {
        return RandomID.shared.randomString()
    }
    
    // compute transaction cost
    var transactionCost: Double {
        if amount < 49 && amount <= 100 {
            return 0.0
        } else if amount > 100 && amount <= 500 {
            return 7
        } else if amount > 500 && amount <= 1000 {
            return 13
        } else if amount > 1000 && amount <= 1500 {
            return 23
        } else if amount > 1500 && amount <= 2500 {
            return 33
        } else if amount > 2500 && amount <= 3500 {
            return 53
        } else if amount > 3500 && amount <= 5000 {
            return 57
        } else if amount > 5000 && amount <= 7500 {
            return 78
        } else if amount > 7500 && amount <= 10_000 {
            return 90
        } else if amount > 10_000 && amount <= 15_000 {
            return 100
        } else if amount > 15_000 && amount <= 20_000 {
            return 105
        }
        return 0.0
    }
    
    // handle less balance
    @State private var showFulizaAlert: Bool = false
    @State private var fulizaAmount: Double = 0.0
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ZStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Favorite Numbers")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                                .padding(.top, 12)
                            
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
                                Text("Save your favorite numbers for quick transactions. Just tap on the star to add")
                                
                            }
                            .foregroundStyle(.green)
                            .font(.subheadline)
                            
                            // MARK: Text fields
                            TextField("Enter Phone No.", text: $phoneNumber)
                                .keyboardType(.numberPad)
                                .padding(10)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.gray, lineWidth: 0.5)
                                }
                                .onChange(of: phoneNumber) { result in
                                    if phoneNumber == "0712345678" {
                                        ownnNumber = true
                                    }
                                    phoneNumber = String(phoneNumber.prefix(phoneNumberLimit))
                                }
                            
                            ZStack {
                                TextField("Enter Amount.", value: $amount, format: .number)
                                    .keyboardType(.numberPad)
                                    .padding(10)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.gray, lineWidth: 0.5)
                                    }
                                
                                if amount != 0 {
                                    Image(systemName: "xmark")
                                        .font(.caption)
                                        .padding(6)
                                        .overlay {
                                            Circle()
                                                .fill(.gray.opacity(0.4))
                                        }
                                        .offset(x: 170)
                                        .onTapGesture {
                                            amount = 0
                                        }
                                        .padding(.trailing, 20)
                                }
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
                                        .fill(phoneNumber.count < 10 ? .gray : .green)
                                }
                                .onTapGesture {
                                    guard !phoneNumber.isEmpty else { return }
                                    
                                    isLoading = true
                                    
                                    
                                    let value = pathToTake(amount: amount, transactionCost: transactionCost)
                                    
                                    // called when balance is less than amount to be sent
                                    if value {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            fulizaAmount = (amount + transactionCost) - mpesaBalance.mpesaBalance
                                            isLoading = false // <- remove progress view
                                            showFulizaAlert = true
                                        }
                                    } else { // <- called when balance is greater than amount
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            withAnimation(.easeIn) {
                                                isLoading = false
                                                sendTo.toggle()
                                            }
                                        }
                                    }
                                }
                            
                            // MARK: Do more
                            Text("Do More")
                                .font(.subheadline)
                                .foregroundStyle(.gray)
                            
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(colorScheme == .light ? .white : Color("buttonColor"))
                                .frame(maxWidth: .infinity)
                                .frame(height: 100)
                                .shadow(radius: 4)
                                .overlay {
                                    HStack {
                                        VStack(alignment: .center, spacing: 10) {
                                            Image(systemName: "person.3")
                                                .foregroundStyle(.green)
                                                .imageScale(.small)
                                                .padding(10)
                                                .overlay {
                                                    Circle()
                                                        .stroke(Color.green, lineWidth: 1.0)
                                                }
                                            
                                            Text("Send to Many")
                                                .font(.subheadline)
                                                .fontWeight(.light)
                                                .foregroundStyle(.gray)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Rectangle()
                                            .fill(.gray)
                                            .frame(height: 50)
                                            .frame(width: 1)
                                        
                                        VStack(alignment: .center, spacing: 10) {
                                            Image(systemName: "creditcard")
                                                .foregroundStyle(.green)
                                                .imageScale(.small)
                                                .padding(10)
                                                .overlay {
                                                    Circle()
                                                        .stroke(Color.green, lineWidth: 1.0)
                                                }
                                            
                                            Text("Pay Me")
                                                .font(.subheadline)
                                                .fontWeight(.light)
                                                .foregroundStyle(.gray)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                    }
                                    .padding(.horizontal, 18)
                                }
                            
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(.green.opacity(0.2))
                                .frame(maxWidth: .infinity)
                                .frame(height: 120)
                                .shadow(radius: 4)
                                .overlay {
                                    VStack(alignment: .leading) {
                                        Text("Looking for something else?")
                                            .foregroundStyle(.gray)
                                            .padding(.bottom, 10)
                                        
                                        Group {
                                            Text("Pochi La Biashara")
                                            Text("Data Bundles")
                                            Text("Share Data Bundles")
                                        }
                                        .foregroundStyle(.green)
                                        .font(.subheadline)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 18)
                                }
                            
                            Spacer()
                            
                            
                        }
                        .padding(.horizontal, 8)
                        .navigationTitle("Send Money")
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarTitleTextColor(.white)
                        .navigationBarBackButtonHidden(true)
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
                        .confirmationDialog("", isPresented: $ownnNumber) {
                            Button("Please transact with a different number other than your own", action: { phoneNumber = "" })
                            Button("Cancel", role: .cancel) { phoneNumber = "" }
                        } message: {
                            Text("Error")
                        }
                    }
                    .blur(radius: sendTo || isLoading || showFulizaAlert || hakikishaAlert ? 5 : 0)
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
                    .sheet(isPresented: $usePin,
                           content: {
                        PinView(
                            amount: amount,
                            showTransactionText: true,
                            login: { success in
                                if success {
                                    mpesaBalance.deductAmount(amount: amount, transaction: transactionCost)
                                    successfulAuth = true
                                }
                            }
                        )
                    })
                    
                    
                    VStack(spacing: 20) {
                        if sendTo {
                            PopUp(
                                popUse: "Send Money To",
                                popName: "Hussein Muktar",
                                grayButton: "CANCEL",
                                greenButton: "SEND",
                                cancel: $sendTo,
                                hakikishaAlert: $hakikishaAlert,
                                amount: amount,
                                transactionCost: transactionCost,
                                greenButtonAction: handlerfunc
                            )
                        }
                        
                        if showFulizaAlert {
                            FulizaView(
                                amount: amount,
                                fulizaAmount: fulizaAmount,
                                phoneNumber: phoneNumber,
                                transactionCost: transactionCost,
                                showFulizaAlert: $showFulizaAlert
                            )
                        }
                        
                        if isLoading {
                            ProgressView()
                                .scaleEffect(CGSize(width: 1.4, height: 1.4))
//                                .controlSize(.large)
                                .tint(.green)
                                .offset(y: -80)
                        }
                        
                      
                    }
                    .offset(y: -100)
                    
                    if hakikishaAlert {
                        HakikishaAlert(hakikishaAlert: $hakikishaAlert)
                            .offset(y: 260)
                    }
                }
                
                Rectangle()
                    .fill(colorScheme == .light ? .green : Color("buttonColor"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 93)
                    .ignoresSafeArea()
                
            }
        }
    }
    
    func pathToTake(amount: Double, transactionCost: Double) -> Bool {
        if mpesaBalance.mpesaBalance < (amount + transactionCost) {
            return true
        }else {
            return false
        }
    }
    
    func handlerfunc() {
        guard phoneNumber.count == 10 && amount != 0 else { return }
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
    SendMoney()
}

struct HakikishaAlert: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var hakikishaAlert: Bool
    var body: some View {
        RoundedRectangle(cornerRadius: 25.0)
            .fill(colorScheme == .light ? .white.opacity(0.7) : Color("buttonColor"))
            .frame(width: 350, height: 150)
            .shadow(radius: 4)
            .overlay {
                VStack(spacing: 16) {
                    Text("Please note that cancelling Hakikisha 5 times consecutively will lead to your Hakikisha being blocked for 48 hours")
                        .foregroundStyle(.primary.opacity(0.7))
                    
                    Rectangle()
                        .fill(.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                    
                    Text("OK")
                        .font(.title3)
                        .foregroundStyle(.blue)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                hakikishaAlert.toggle()
                            }
                        }
                }
                .font(.subheadline)
                .padding()
                .multilineTextAlignment(.center)
            }
        
    }
}
