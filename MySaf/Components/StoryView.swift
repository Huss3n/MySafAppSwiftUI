//
//  ImageView.swift
//  MySaf
//
//  Created by Muktar Hussein on 16/05/2024.
//

import SwiftUI

struct StoryView: View {
    var imageName: String = "rocket"
    var title: String = "Title"
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 68)
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(Color.green, lineWidth: 2.0)
                }
            
            Text(title)
                .font(.subheadline)
        }
    }
}

#Preview {
    StoryView()
}
