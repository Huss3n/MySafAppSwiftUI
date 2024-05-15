//
//  CustomTabBar.swift
//  MySaf
//
//  Created by Muktar Hussein on 15/05/2024.
//

import SwiftUI

struct CustomTabBar: View {
    var body: some View {
        TabView {
            Text("Home")
                .tabItem {
                    Image(systemName: "house")
                }
            
            Text("Mpesa")
                .tabItem {
                    Image("send")
                        .resizable()
                        .scaledToFit()
                }
            
            Text("Edit")
                .tabItem {
                    Image("safLogo")
                        .resizable()
                        .scaledToFit()
                }
            
            Text("Discover")
                .tabItem {
                    Image("gift")
                        .frame(width: 20, height: 20)
//                        .resizable()
//                        .scaledToFit()
                }
        }
    }
}

#Preview {
    CustomTabBar()
}
