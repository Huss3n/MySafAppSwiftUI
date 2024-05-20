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
        NavigationStack {
            TabView(selection: $tabSelection) {
                HomeView()
                    .tag(1)
                
                MpesaView()
                    .tag(2)
                
                SPage()
                    .tag(3)
                
                
                Categories()
                    .tag(4)
                
                Account()
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
