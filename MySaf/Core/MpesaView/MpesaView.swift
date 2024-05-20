//
//  MpesaView.swift
//  MySaf
//
//  Created by Muktar Hussein on 17/05/2024.
//

import SwiftUI

struct MpesaView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showBalance: Bool = false
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 6, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil),
        GridItem(.flexible(), spacing: 6, alignment: nil)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                    VStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(colorScheme == .dark ? Color("buttonColor") : .white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .shadow(radius: 5)
                            .overlay {
                                Text("Show Balance")
                                    .font(.headline)
                                    .foregroundStyle(.green)
                            }
//                            .padding(.top, 6)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    showBalance.toggle()
                                }
                            }
                        
                        LazyVGrid(columns: columns, content: {
                            NavigationLink {
                                SendMoney()
                            } label: {
                                MpesaButton(imageName: "send-money", text: "Send Money")
                            }
                            .tint(.primary)

                            NavigationLink {
                                Withdraw()
                            } label: {
                                MpesaButton(imageName: "mobile-payment", text: "Withdraw Cash")
                            }
                            .tint(.primary)

                            MpesaButton(imageName: "call", text: "Buy Airtime")
                            MpesaButton(imageName: "basket", text: "Lipa na M-PESA")
                            MpesaButton(imageName: "receipt", text: "Bill Manager")
                            MpesaButton(imageName: "e-sim", text: "Loans & Savings")
                            MpesaButton(imageName: "mobile-payment", text: "Fuliza M-PESA")
                            MpesaButton(imageName: "globe", text: "M-PESA")
                            MpesaButton(imageName: "accountRow", text: "Account")
                        })
                        
                        // MARK: Mpesa statement button
                        RoundedRectangle(cornerRadius: 25)
                            .fill(colorScheme == .dark ? Color("buttonColor") : .white)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .shadow(radius: 5)
                            .overlay {
                                HStack {
                                    Image("feather")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                    
                                    Text("M-PESA Statement")
                                        .font(.headline)
                                        .foregroundStyle(.green)
                                }
                            }
                        
                        // MARK: Scan to pay button
                        RoundedRectangle(cornerRadius: 25)
                            .fill(.red)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .shadow(radius: 5)
                            .overlay {
                                HStack {
                                    Image(systemName: "qrcode")
                                        .font(.title2)
                                        .fontWeight(.semibold)
        //                                .frame(width: 35, height: 35)
                                    
                                    Text("M-PESA Statement")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                }
                            }
                        
                        HStack {
                            // MARK: Mpesa Go
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorScheme == .light ? .white : Color("buttonColor"))
                                .frame(width: 110, height: 110)
                                .shadow(radius: 3)
                                .overlay {
                                    VStack(alignment: .center, spacing: 8) {
                                        Image("goIcon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        
                                        VStack(alignment: .center, spacing: 2) {
                                            Text("M-PESA")
                                                .font(.subheadline)
                                                .lineLimit(2)
                                            
                                            Text("Go")
                                        }
                                    }
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    
                                }
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(colorScheme == .light ? .white : Color("buttonColor"))
                                .frame(width: 260, height: 110)
                                .shadow(radius: 3)
                                .overlay {
                                    VStack(alignment: .center, spacing: 8) {
                                        Image("briefcase")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                        
                                        VStack(alignment: .center, spacing: 2) {
                                            Text("Lipa na M-PESA Portal")
                                                .font(.subheadline)
                                                .lineLimit(2)
                                            
                                            Text("Apply for Till & Paybill solutions to collect & disburse funds")
                                                .lineLimit(4)
                                                .font(.caption)
                                        }
                                        .multilineTextAlignment(.center)
                                    }
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    
                                }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 8)
//                    .navigationTitle("M-PESA")
//                    .navigationBarTitleTextColor(.white)
                    .navigationBarTitleDisplayMode(.inline)
                    .fullScreenCover(isPresented: $showBalance, content: {
                     ShowBalanceView()
                    })
                    .padding(.top, 18)
                    .offset(y: 30)
                
                Rectangle()
                    .fill(colorScheme == .light ? .green : Color("buttonColor"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 93)
                    .overlay {
                        Text("M-PESA")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .offset(y: 20)
                    }
                    .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    NavigationStack {
        MpesaView()
    }
}

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}

struct ShowBalanceView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                Text("M-PESA Balance View")
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "arrow.left")
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
}
