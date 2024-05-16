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
                        .scaledToFill()
                        .frame(width: 55, height: 48)
//                        .clipShape(Circle())
                    
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
            }
            .shadow(radius: 3)
    }
}

#Preview {
    GridRow()
}
