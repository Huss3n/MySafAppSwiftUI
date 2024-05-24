//
//  CheckMarkAnimation.swift
//  MySaf
//
//  Created by Muktar Hussein on 23/05/2024.
//

import SwiftUI

struct CheckMarkAnimation: View {
    @State private var drawPercentage1: CGFloat = 1
    @State private var drawPercentage2: CGFloat = 1
    @State private var drawCircle: CGFloat = 0
    var lineWidth: CGFloat = 6
    var markScale: CGFloat = 0.7
    
    var startAnimation: Bool
    
    var body: some View {
        ZStack {
            Group {
                Path { path in
                    path.move(to: CGPoint(x: 70 * markScale, y: 60 * markScale ))
                    path.addLine(to: CGPoint(x: 108 * markScale, y: 100 * markScale ))
                }
                .trim(from: 0, to: drawPercentage1)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                
                Path { path in
                    path.move(to: CGPoint(x: 108 * markScale, y: 100 * markScale ))
                    path.addLine(to: CGPoint(x: 155 * markScale, y: 10 * markScale ))
                }
                .trim(from: 0, to: drawPercentage2)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            }
            .offset(x: -40 * markScale, y: 5 * markScale)
            
            Circle()
                .trim(from: 0, to: drawCircle)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .frame(width: 100, height: 100)
                .rotationEffect(.degrees(-50))
        }
        .foregroundStyle(.green)
        .frame(width: 10 * markScale, height: 100 * markScale)
        .onAppear(perform: {
            if startAnimation {
                animate()
            }
        })
    }
    
    func animate() {
        drawPercentage1 = 0
        drawPercentage2 = 0
        drawCircle = 0
        
        withAnimation(.easeInOut(duration: 0.3)) {
            drawPercentage1 = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.easeInOut(duration: 0.5)) {
                drawPercentage2 = 1.5
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeInOut(duration: 0.6)) {
                drawCircle = 1.0
            }
        }
    }
}
#Preview {
    CheckMarkAnimation(startAnimation: true)
}
