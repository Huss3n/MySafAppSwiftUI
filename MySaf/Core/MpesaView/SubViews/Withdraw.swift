//
//  WithdrawView.swift
//  MySaf
//
//  Created by Muktar Hussein on 17/05/2024.
//

import SwiftUI

struct Withdraw: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss
    @State private var agentNumber: String = ""
    
    @State private var storeNumber: String = ""
    @State private var amount: String = ""
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
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
                    
                    TextField("Enter Amount (min: 50).", text: $amount)
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
                                .fill(.green)
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
    Withdraw()
}
