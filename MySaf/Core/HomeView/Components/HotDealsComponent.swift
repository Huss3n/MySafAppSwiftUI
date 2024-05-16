//
//  HotDealsComponent.swift
//  MySaf
//
//  Created by Muktar Hussein on 16/05/2024.
//

import SwiftUI

struct HotDealsComponent: View {
    var offer1: String = ""
    var offer2: String = ""
    var body: some View {
       RoundedRectangle(cornerRadius: 6)
            .fill(Color("hotDealsColor"))
            .frame(width: 250, height: 130)
            .overlay {
                VStack(alignment: .leading) {
                    Text("Get")
                        .padding(.bottom, 12)
                    Text(offer1)
                    Text(offer2)
                    
                    
                    Image("gift")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .frame(maxWidth: .infinity, alignment: .bottomTrailing)
                        .padding(.trailing, 12)
                }
                .padding(.leading, 24)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
    }
}

#Preview {
    HotDealsComponent()
}
