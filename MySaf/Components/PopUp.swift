//
//  PopUp.swift
//  MySaf
//
//  Created by Muktar Hussein on 23/05/2024.
//

import SwiftUI

struct PopUp: View {
    @Environment(\.colorScheme) var colorScheme
    var popUse: String = "Send To"
    var popName: String = "Hussein"
    var grayButton: String = "CANCEL"
    var greenButton: String = "WITHDRAW"
    @Binding var cancel: Bool
    @Binding var hakikishaAlert: Bool
    var amount: Double = 200.0
    var transactionCost: Double = 20.0
    var greenButtonAction: () -> Void
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(colorScheme == .light ? .white.opacity(0.7) : Color("buttonColor"))
            .padding(.horizontal, 30)
            .frame(height: 230)
            .shadow(radius: 2)
            .overlay {
                overlayContent
            }
    }
}

#Preview {
    PopUp(cancel: .constant(true), hakikishaAlert: .constant(true), greenButtonAction: {})
}

extension PopUp {
    private var overlayContent: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(popUse)
                .font(.caption)
                .foregroundStyle(.green)
            
            Text(popName)
                .font(.headline)
                .fontWeight(.medium)
            
            Rectangle()
                .fill(.gray.opacity(0.5))
                .frame(maxWidth: .infinity)
                .frame(height: 2)
            
            HStack {
                VStack {
                    Text("Amount:")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                    
                    Text(String(format: "%.2f", amount))
                        .font(.headline)
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Rectangle()
                    .fill(.gray.opacity(0.5))
                    .frame(width: 2, height: 20)
                
                
                VStack {
                    Text("Transaction Cost:")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                    Text(String(format: "%.2f", transactionCost))
                        .font(.headline)
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .offset(x: -30)
            }
            .padding(.top, 12)
            
            Rectangle()
                .fill(.gray.opacity(0.5))
                .frame(maxWidth: .infinity)
                .frame(height: 2)
            
            HStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.gray)
                    .frame(width: 120, height: 30)
                    .overlay {
                        Text(grayButton)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                withAnimation(.bouncy) {
                                    withAnimation(.easeOut) {
                                        cancel.toggle()
                                    }
                                    withAnimation(.easeIn) {
                                        hakikishaAlert.toggle()
                                    }
                                }
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(.green)
                    .frame(width: 120, height: 30)
                    .overlay {
                        Text(greenButton)
                            .foregroundStyle(.black)
                            .onTapGesture {
                                greenButtonAction()
                            }
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.top, 12)
        }
        .padding(.horizontal, 42)
    }
}
