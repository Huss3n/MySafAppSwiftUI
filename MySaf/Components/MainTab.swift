//
//  MainTab.swift
//  MySaf
//
//  Created by Muktar Hussein on 16/05/2024.
//

import SwiftUI

@MainActor
class MainEntry: ObservableObject {
    @Published var isUserAuthenticated: Bool = false
    @Published var showPinView: Bool = false
    
    func authUser(reason: String) async {
        isUserAuthenticated = await LocalAuth.shared.authenticateWithBiometrics(reason: reason)
    }
}

struct MainTab: View {
    @State private var tabSelection = 1
    @StateObject private var vm = MainEntry()
    
    var body: some View {
        ZStack {
            if vm.isUserAuthenticated {
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
                    .onAppear {
                        NotificationManager.shared.requestPermission()
                    }
                }
            } else {
                PinView(showTransactionText: false) { success in
                    if success {
                        withAnimation(.easeIn) {
                            vm.isUserAuthenticated = true
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await vm.authUser(reason: "Log into mySafaricom App")
            }
        }
    }
}

#Preview {
    MainTab()
}
