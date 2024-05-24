//
//  ErrorAnimation.swift
//  MySaf
//
//  Created by Muktar Hussein on 23/05/2024.
//

import SwiftUI

struct ErrorAnimation: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var drawCircle: CGFloat = 0
    var lineWidth: CGFloat = 2
    var markScale: CGFloat = 0.7
    @Binding var dismiss: Bool
    
    var startAnimation: Bool
    var body: some View {
        VStack(alignment: .center, spacing: 18) {
            ZStack {
                Image(systemName: "exclamationmark")
                    .font(.title)
                    .fontWeight(.medium)
                
                Circle()
                    .trim(from: 0, to: drawCircle)
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .frame(width: 80, height: 80)
                    .rotationEffect(.degrees(-50))
            }
            .foregroundStyle(.red)
            .frame(width: 10 * markScale, height: 100 * markScale)
            
            Text("Agent details do not match")
            
            
            Text("OK")
                .foregroundStyle(.white)
                .font(.headline)
                .fontWeight(.medium)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 25)
                        .fill(.green)
                }
                .onTapGesture {
                    dismiss.toggle()
                }
            
        }
        .padding()
        .frame(width: 350, height: 250)
        .background(colorScheme == .light ? .white.opacity(0.7) : Color("buttonColor"))
        .shadow(radius: 2)
        .cornerRadius(30)
        .onAppear(perform: {
            if startAnimation {
                animate()
            }
        })

    }
    
    func animate() {
        drawCircle = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeInOut(duration: 0.8)) {
                drawCircle = 1.0
            }
        }
    }
}
#Preview {
    ErrorAnimation(dismiss: .constant(true), startAnimation: true)
}
