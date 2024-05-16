//
//  MainTab.swift
//  MySaf
//
//  Created by Muktar Hussein on 16/05/2024.
//

import SwiftUI

struct MainTab: View {
    @State private var tabSelection = 1
    
    var body: some View {
        ZStack {
            TabView(selection: $tabSelection) {
                HomeView()
                    .tag(1)
                
                Text("mpesa")
                    .tag(2)
                
                Text("gift")
                    .tag(3)
                
                
                Text("discover")
                    .tag(4)
                
                Text("account")
                    .tag(5)
            }
            .overlay(alignment: .bottom) {
                CustomTabBar(tabSelection: $tabSelection)
            }
        }
    }
}

#Preview {
    MainTab()
}
