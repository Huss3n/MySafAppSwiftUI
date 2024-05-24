//
//  PinView.swift
//  MySaf
//
//  Created by Muktar Hussein on 21/05/2024.
//

import SwiftUI

struct PinView: View {
    var amount: Double = 500
    var showTransactionText: Bool = true
    var login: (Bool) -> (Void)
    
//    var transactionType: TransactionType
    
    @State private var pin = ""
    @State private var showPin = false // Flag to control showing actual digits
    
    let allowedChars = Set("0123456789")
    let maxPinLength = 4 // Maximum pin length
    
    var correctPin = "1234"
    
   
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
            if showTransactionText {
                VStack(spacing: 6) {
                    HStack {
                        Text("Enter your M-PESA PIN to send")
                        Text("Ksh. \(String(format: "%.2f", amount))")
                            .foregroundStyle(.green)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                    HStack {
                        Text("to" )
                        Text("HUSSEIN MUKTAR")
                            .foregroundStyle(.green)
                            .font(.headline)
                            .fontWeight(.semibold)
                    }
                }
                .foregroundStyle(.gray)
                .fontWeight(.medium)
                .padding(.bottom, 80)
            } else {
                VStack(spacing: 20) {
                    Image("safTabLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    Text("Use faceid or M-PESA PIN to unlock")
                        .font(.headline)
                }
                
                .padding(.bottom, 80)
                
            }
            
            HStack {
                HStack {
                    ZStack {
                        if pin.isEmpty {
                            Text("Enter M-PESA PIN")
                                .font(.subheadline)
                        }
                        
                        if showPin {
                            Text(pin)
                                .font(.title3)
                                .foregroundStyle(pin.isEmpty ? .gray : .primary)
                                .fontWeight(pin.isEmpty ? .light : .semibold)
                            
                        } else {
                            HStack {
                                ForEach(0..<pin.count, id: \.self) { _ in
                                    Image(systemName: "circle.fill")
                                        .imageScale(.small)
                                }
                            }
                        }
                    }
                }
                .frame(width: 130)
                Image(systemName: showPin ? "eye" : "eye.slash")
                    .imageScale(.medium)
                    .offset(x: 100)
                    .onTapGesture {
                        showPin.toggle()
                    }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            //            .background(.red)
            
            Rectangle()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
            
            // Keypad buttons
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                ForEach(1..<10) { number in
                    Button("\(number)") {
                        if pin.count < maxPinLength && allowedChars.contains("\(number)") {
                            pin.append("\(number)")
                        }
                    }
                    .buttonStyle(.plain)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                    .frame(width: (UIScreen.main.bounds.width - 64) / 3, height: 50)
                    .padding(16)
                }
                Text("X")
                    .font(.title)
                    .foregroundStyle(.red)
                    .onTapGesture {
                        if !pin.isEmpty {
                            pin.removeLast()
                        }
                    }
                
                
                Text("0")
                    .font(.title)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        if pin.count < maxPinLength {
                            pin.append("0")
                        }
                    }
                
                if showTransactionText {
                    Text("OK")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.green)
                        .onTapGesture {
                            checkPin()
                            
                        }
                } else {
                    Image(systemName: biometryString())
                        .onTapGesture {
                            Task.init {
                                await LocalAuth.shared.authenticateWithBiometrics(reason:"Use Face ID to login")
                            }
                        }
                }
            }
        }
        .onChange(of: pin) {
            checkPin()
        }
    }
    
    
    
    func biometryString() -> String {
        let biometry = LocalAuth.shared.getBiometryType()
        if biometry == .faceID {
            return "faceid"
        } else {
            return "touchid"
        }
    }
    
    func checkPin() {
           if pin.count == maxPinLength {
               if pin == correctPin {
                   login(true)
               } else {
                   login(false)
               }
           }
       }
}

//
//#Preview {
////    PinView(login: { _ in })
//}
