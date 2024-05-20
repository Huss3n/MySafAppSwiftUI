//
//  SendMoneyView.swift
//  MySaf
//
//  Created by Muktar Hussein on 17/05/2024.
//

import SwiftUI

struct SendMoney: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var phoneNumber: String = ""
    @State private var amount: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
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
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 0.5)
                        }
                    
                    ZStack {
                        TextField("Enter Amount.", text: $amount)
                            .keyboardType(.numberPad)
                            .padding()
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.gray, lineWidth: 0.5)
                            }
                        
                        if !amount.isEmpty {
                            Image(systemName: "xmark")
                                .font(.caption)
                                .padding(6)
                                .overlay {
                                    Circle()
                                        .fill(.gray.opacity(0.4))
                                }
                                .offset(x: 170)
                                .onTapGesture {
                                    amount = ""
                                }
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
                                .fill(phoneNumber.count < 8 || amount.count < 1 ? .gray : .green)
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
                
                
                Rectangle()
                    .fill(colorScheme == .light ? .green : Color("buttonColor"))
                    .frame(maxWidth: .infinity)
                    .frame(height: 93)
                    .ignoresSafeArea()

            }
            
        }
    }
}

#Preview {
    SendMoney()
}
