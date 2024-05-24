//
//  MySafApp.swift
//  MySaf
//
//  Created by Muktar Hussein on 14/05/2024.
//

import SwiftUI
import Network

// <- check network connection
class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}



@main
struct MySafApp: App {
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            MainTab()
                .environmentObject(networkMonitor)
        }
    }
}
