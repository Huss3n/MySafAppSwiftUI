//
//  TopView.swift
//  MySaf
//
//  Created by Muktar Hussein on 16/05/2024.
//

import SwiftUI

struct TopView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 2) {
            Text("Good Afternoon")
            Text("Hussein")
                .font(.title)
                .fontWeight(.bold)
               
        }
        .padding()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .top)
        .background(colorScheme == .light ?  .green : .clear)
    }
}

#Preview {
    TopView()
}
