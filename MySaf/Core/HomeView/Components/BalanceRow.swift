//
//  BalaceRow.swift
//  MySaf
//
//  Created by Muktar Hussein on 17/05/2024.
//

import SwiftUI

struct BalanceRow: View {
    @Environment(\.colorScheme) var colorScheme
    var imageName: String = "airtime"
    var title: String = "Airtime"
    var value: String = "KES 136.4"
    @State private var expandView: Bool = false
    
    var height: CGFloat = 180
    
    // MARK: Expandable view
    var subtitle1: String = "Title 1"
    var title1Value: String = "Value"
    
    var subtitle2: String = "Title 2"
    var title2Value: String = "Value"
    
    var subtitle3: String = "Title 3"
    var title3Value: String = "Value"
    
    var subtitle4: String = ""
    var title4Value: String = ""
    
    var subtitle5: String = ""
    var title5Value: String = ""
    
    var button1Text: String = "Button"
    var button2Text: String = "Button"

    var body: some View {
        VStack(spacing: -1) {
            RoundedRectangle(cornerRadius: 6)
                 .fill(colorScheme == .light ? .white : Color("buttonColor"))
                 .frame(maxWidth: .infinity)
                 .frame(height: 58)
                 .overlay {
                     HStack {
                         Image(imageName)
                             .resizable()
                             .scaledToFit()
                             .frame(height: 35)
                         
                         
                         Text(title)
                         
                         Spacer()
                         
                         Text(value)
                         
                         Image(systemName: expandView ? "chevron.down" : "greaterthan")
                             .foregroundStyle(.green)
                             .fontWeight(.medium)
                     }
                     .padding(.horizontal)
                 }
                 .shadow(radius: 0.8)
                 .onTapGesture {
                     withAnimation(.bouncy) {
                         expandView.toggle()
                     }
                 }
            
            if expandView {
                RoundedRectangle(cornerRadius: 0)
                    .fill(colorScheme == .light ? .white : Color("buttonColor"))
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
                    .shadow(radius: 0.8)
                    .overlay {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text(subtitle1)
                                Spacer()
                                Text(title1Value)
                            }
                            
                            HStack {
                                Text(subtitle2)
                                Spacer()
                                Text(title2Value)
                            }
                            
                            if !subtitle3.isEmpty {
                                HStack {
                                    Text(subtitle3)
                                    Spacer()
                                    Text(title3Value)
                                }
                            }
                            
                            if !subtitle4.isEmpty {
                                HStack {
                                    Text(subtitle4)
                                    Spacer()
                                    Text(title4Value)
                                }
                            }
                            
                            if !subtitle5.isEmpty {
                                HStack {
                                    Text(subtitle5)
                                    Spacer()
                                    Text(title5Value)
                                }
                            }
                            
                            HStack {
                                if !button1Text.isEmpty {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .stroke(Color.green, lineWidth: 1.0)
                                        .frame(width: 160, height: 40)
                                        .overlay {
                                            Text(button1Text)
                                                .foregroundStyle(.green)
                                        }
                                }
                                
                                Spacer()
                                
                                if !button2Text.isEmpty {
                                    RoundedRectangle(cornerRadius: 25.0)
                                        .fill(.green)
                                        .frame(width: 160, height: 40)
                                        .overlay {
                                            Text(button2Text)
                                                .foregroundStyle(Color("buttonColor"))
                                        }
                                }
                            }
                            .padding(.top, 10)
                        }
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .padding(.horizontal)
                        
                    }
            }
        }
    }
}

#Preview {
    BalanceRow()
}
