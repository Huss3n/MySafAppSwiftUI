//
//  CustomTabBar.swift
//  MySaf
//
//  Created by Muktar Hussein on 15/05/2024.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    let tabItems = ["home", "send", "safTabLogo", "gift", "account"]
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(height: 0.3)
                .offset(y: -28)
            
            HStack {
                ForEach(0..<5) { index in
                    Button(action: {
                        tabSelection = index + 1
                    }, label: {
                        HStack {
                            Spacer()
                            
                            VStack(spacing: 8) {
                                Image(tabItems[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: tabItems[index] == "safTabLogo" ? 60 : 30 , height: tabItems[index] == "safTabLogo" ? 60 : 30)
                                    .foregroundStyle(index + 1 == tabSelection ? .green : .gray)
                                    .offset(y: tabItems[index] == "safTabLogo" ? -23 : 0)
                                
                                if index + 1 == tabSelection {
                                    Capsule()
                                        .frame(width: 24, height: 4)
                                        .matchedGeometryEffect(id: "selectedTabID", in: animationNamespace)
//                                        .offset(y: -3)
                                }else {
                                    Capsule()
                                        .foregroundStyle(.clear)
                                        .frame(width: 24, height: 4)
                                }
                            }
                        }
                        .foregroundStyle(index + 1 == tabSelection ? .green : .black)
                        .padding(12)
                    })
                }
            }
            .background(.primary.opacity(0.08))
            .frame(height: 80)
            .padding(4)
            .offset(y: 17)
        }
//        .padding(.horizontal)
    }
}

#Preview {
    CustomTabBar(tabSelection: .constant(1))
}
