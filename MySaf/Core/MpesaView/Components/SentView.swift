//
//  SentView.swift
//  MySaf
//
//  Created by Muktar Hussein on 22/05/2024.
//

import SwiftUI

struct SentView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss  
    @ObservedObject var mpesaBalance = MpesaBalance.instance
    var amount: Double = 500
    var phoneNumber: String = "0712345687"
    var transactionCost: Double = 0.0
    var randomID: String = ""
    var transactionType: TransactionType
    @State private var showBalance: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            VStack(spacing: 30) {
                CheckMarkAnimation(startAnimation: true)
                
                Text(transactionType == .airtime ? "The service request is processed successfully" : "Your transaction was successful!")
            }
            .foregroundStyle(.green)
            .frame(maxWidth: .infinity, alignment: .center)
            
            RoundedRectangle(cornerRadius: 15.0)
                .fill(colorScheme == .light ? .white : Color("buttonColor"))
                .shadow(radius: 4)
                .frame(height: transactionType == .airtime ? 250 : 300)
                .overlay {
                    VStack(spacing: 14) {
           
                        if transactionType == .send || transactionType == .withdraw {
                            HStack {
                                Text(transactionType == .send ? "Sent To:" : "Agent Name")
                                    .font(.subheadline)
                                Spacer()
                                Text(transactionType == .send ? "HUSSEIN MUKTAR" : "Hello World")
                            }
                            
                            HStack {
                                Text("Amount:")
                                    .font(.subheadline)
                                Spacer()
                                Text("Ksh.\(String(format: "%.2f", amount))")
                            }
                            
                            HStack {
                                Text("Transaction Cost:")
                                    .font(.subheadline)
                                Spacer()
                                Text("Ksh.\(String(format: "%.2f", transactionCost))")
                            }
                        }
                        
                        if transactionType == .airtime {
                            HStack {
                                Text("Airtime Amount:")
                                    .font(.subheadline)
                                Spacer()
                                Text("Ksh.\(String(format: "%.2f", amount))")
                            }
                        }

                        
                        HStack {
                            Text("Transaction ID:")
                                .font(.subheadline)
                            Spacer()
                            Text(randomID.uppercased())
                        }
                        
                        HStack {
                            Text("Date/Time:")
                                .font(.subheadline)
                            Spacer()
                            Text("22-05-2024 8.45")
                        }
                        
                        HStack {
                            VStack(spacing: 4) {
                                Text(showBalance ? "Hide Balance" : "Show Balance")
                                Rectangle()
                                    .frame(width: 100, height: 1)
                            }
                            .foregroundStyle(showBalance ? .red : .green)
                            .fontWeight(.semibold)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    showBalance.toggle()
                                }
                            }
                            Spacer()
                            
                            if showBalance {
                                Text("Ksh.\(String(format: "%.2f", mpesaBalance.mpesaBalance))")
                            }
                        }
                        
                        
                        Text("DONE")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.green)
                            .clipShape(Capsule())
                            .onTapGesture {
                                withAnimation(.easeOut) {
                                    dismiss()
                                }
                                if transactionType == .send {
                                    makeNotificationCall()
                                } else if transactionType == .withdraw {
                                    makeNotificationCallForWithdraw()
                                } else {
                                    makeNotificationCallForAirtime()
                                }
                            }
                    }
                    .foregroundStyle(.gray)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                }
            
            if transactionType != .airtime {
                HStack(alignment: .center, spacing: 30) {
                    VStack(spacing: 4) {
                        Image(systemName: "star")
                            .imageScale(.medium)
                            .padding()
                            .background(.gray.opacity(0.4))
                            .clipShape(Circle())
                        
                        Text("Add to favorites")
                            .font(.subheadline)
                    }
                    
                    VStack {
                        Image(systemName: "arrow.down.doc")
                            .imageScale(.medium)
                            .padding()
                            .background(.gray.opacity(0.4))
                            .clipShape(Circle())
                        
                        Text("Download receipt")
                            .font(.subheadline)
                    }
                    
                    VStack {
                        Image(systemName: "arrow.turn.up.left")
                            .imageScale(.medium)
                            .padding()
                            .background(.gray.opacity(0.4))
                            .clipShape(Circle())
                        
                        Text("Reverse Transaction")
                            .font(.subheadline)
                        
                        //                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    //                .frame(maxWidth: .infinity, alignment: .center)
                    
                    VStack {
                        Image(systemName: "square.and.arrow.up")
                            .imageScale(.medium)
                            .padding()
                            .background(.gray.opacity(0.4))
                            .clipShape(Circle())
                        
                        Text("Share Details")
                            .font(.subheadline)
                    }
                }
                .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            
        }
        .padding(.horizontal)
        .padding(.top, 32)
//        .offset(y: 50)
    }
    
    
    func makeNotificationCall() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        let timeString = timeFormatter.string(from: date)
        
        if mpesaBalance.mpesaBalance < 0 {
            NotificationManager.shared.sendNotification(
                title: "M-PESA",
                subtitle: "\(randomID.uppercased()) confirmed. Fuliza M-pesa Amount Kshs.\(amount).00 sent to Hussein Muktar \(phoneNumber) on \(dateString) at \(timeString). New M-PESA balance is Ksh\(mpesaBalance.mpesaBalance)",
                badge: 1,
                timeInterval: 3.0
            )
        } else {
            NotificationManager.shared.sendNotification(
                title: "M-PESA",
                subtitle: "\(randomID.uppercased()) confirmed. Kshs.\(amount).00 sent to Hussein Muktar \(phoneNumber) on \(dateString) at \(timeString). New M-PESA balance is Ksh\(mpesaBalance.mpesaBalance)",
                badge: 1,
                timeInterval: 3.0
            )
        }
    }
    
    
    func makeNotificationCallForAirtime() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        let timeString = timeFormatter.string(from: date)
        
        NotificationManager.shared.sendNotification(
            title: "M-PESA",
            subtitle: "\(randomID) confirmed. You bought Ksh.\(amount) of airtime on \(dateString) at \(timeString). New M-PESA balance is Ksh\(mpesaBalance.mpesaBalance). Transaction cost, Ksh\(transactionCost)",
            badge: 0,
            timeInterval: 3.0
        )
    }
    
    func makeNotificationCallForWithdraw() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let dateString = dateFormatter.string(from: date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        let timeString = timeFormatter.string(from: date)
        
        NotificationManager.shared.sendNotification(
            title: "M-PESA",
            subtitle: "\(randomID) confirmed. Withdrawal of Ksh.\(amount) at Hello World on \(dateString) at \(timeString). New M-PESA balance is Ksh\(mpesaBalance.mpesaBalance). Transaction cost, Ksh\(transactionCost)",
            badge: 0,
            timeInterval: 3.0
        )
    }
    
}

#Preview {
    SentView(transactionType: .withdraw)
}
