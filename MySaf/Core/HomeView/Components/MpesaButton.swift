//
//  MpesaButton.swift
//  MySaf
//
//  Created by Muktar Hussein on 17/05/2024.
//

import SwiftUI

struct MpesaButton: View {
    @Environment(\.colorScheme) var colorScheme
    var imageName: String
    var text: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(colorScheme == .light ? .white : Color("buttonColor"))
            .frame(height: 105)
            .shadow(radius: 3)
            .overlay {
                VStack(alignment: .center, spacing: 8) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    Text(text)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .lineLimit(2)
                }
                
            }
    }
}

#Preview {
    MpesaButton(imageName: "airtime", text: "Send Money")
}
