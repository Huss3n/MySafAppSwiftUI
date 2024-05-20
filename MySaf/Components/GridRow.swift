//
//  GridRow.swift
//  MySaf
//
//  Created by Muktar Hussein on 16/05/2024.
//

import SwiftUI

struct GridRow: View {
    @Environment(\.colorScheme) var colorScheme
    
    var imageName: String = ""
    var title: String = ""
    var subtitle: String = ""
    
    var body: some View {
       RoundedRectangle(cornerRadius: 4.0)
            .fill(colorScheme == .light ? .white : Color("buttonColor"))
            .frame(height: 84)
            .overlay {
                HStack(alignment: .center, spacing: 18) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 32)
//                        .clipShape(Circle())
                        .padding(.leading)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text(title)
                            .font(.caption)
                            .fontWeight(.medium)
                        
                        Text(subtitle)
                            .font(.caption2)
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .shadow(radius: 3)
    }
}

#Preview {
    GridRow()
}
