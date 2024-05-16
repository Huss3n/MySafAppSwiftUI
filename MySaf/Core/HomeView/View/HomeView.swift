//
//  HomeView.swift
//  MySaf
//
//  Created by Muktar Hussein on 16/05/2024.
//

import SwiftUI

enum Theme {
    static let light: Color = .white
    static let dark: Color = .black
}

struct HomeView: View {
    @AppStorage("systemThemeValue") private var systemThemeValue: Int = SchemeType.allCases.first!.rawValue
    @State private var isDarkMode: Bool = false // User preference for dark mode
    @Environment(\.colorScheme) private var colorScheme: ColorScheme // System color scheme
    
    // Computed property for current theme based on user preference and system color scheme
    private var currentTheme: String {
        if isDarkMode {
            return "Dark" // User preference overrides system color scheme
        } else {
            return colorScheme == .light ? "Light" : "Dark"
        }
    }
    
    @State private var selectedTheme: ColorScheme = .light // Initialize with a default theme
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                zGroup
                VStack(alignment: .leading) {
                        ScrollView {
                            // MARK: Story views - has horizontal scroll view
                            storyViews
                            
                            // MARK: Sliding image and two grid rows
                            imageSlidesButtons
                            
                            // MARK: Start of grid
                            gridButtons
                            
                            // MARK: Hot deals
                            Text("HOT DEALS")
                                .foregroundStyle(.gray)
                                .fontWeight(.light)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    HotDealsComponent(offer1: "Sh 100 = 2GB, 24 Hr", offer2: "+FREE Gmaps")
                                    HotDealsComponent(offer1: "Sh 20 (30 Minutes, 3hrs")
                                    HotDealsComponent(offer1: "Sh 20 = 200MB + 10 Mins,", offer2: "1hr")
                                    HotDealsComponent(offer1: "Sh 50 (Kredo,", offer2: "125, Midnight")
                                    HotDealsComponent(offer1: "Sh 10 = 1024MB", offer2: "TikTok, 1Hr")
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        .frame(maxHeight: .infinity)
                        .background(.red)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            HStack {
                                Image(systemName: isDarkMode ? "moonphase.first.quarter.inverse" : "sun.min")
                                    .imageScale(.large)
                                Text(isDarkMode ? "Dark Mode" : "Light Mode")
                            }
                            .foregroundStyle(.white)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    isDarkMode.toggle()
                                    // Update selectedTheme directly based on isDarkMode
                                    selectedTheme = isDarkMode ? .dark : .light
                                }
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            HStack(spacing: 30) {
                                Image(systemName: "magnifyingglass")
                                Image(systemName: "bell.badge")
                            }
                            .foregroundStyle(.white)
                        }
                    }
                    .offset(y: 138)
                    .padding(.horizontal, 4)
                    .frame(maxHeight: .infinity)
                    .background(.yellow)
            }
            .frame(maxHeight: .infinity)
            .preferredColorScheme(selectedTheme) // Apply the selected theme
        }
    }
}

#Preview {
    HomeView()
}

enum SchemeType: Int, Identifiable, CaseIterable {
    var id: Self { self }
    case light
    case dark
}

extension SchemeType {
    var title: String {
        switch self {
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }
}


extension HomeView {
    private var balancesButton: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(isDarkMode ? Color("buttonColor") : .white)
            .fontWeight(.semibold)
            .frame(width: 250, height: 50)
            .shadow(radius: 10)
            .overlay {
                Text("View my Balances")
                    .font(.headline)
                    .foregroundStyle(.green)
                //                    .background(.white)
            }
    }
    
    private var zGroup: some View {
        Group {
            if isDarkMode {
                Theme.dark
                    .ignoresSafeArea()
            } else {
                Theme.light
                    .ignoresSafeArea()
            }
            
            TopView()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            
            if isDarkMode {
                Rectangle()
                    .fill(.gray)
                    .frame(maxWidth: .infinity)
                    .frame(height: 0.5)
                    .offset(y: -240)
            }
            
            balancesButton
                .offset(y: -240)
        }
    }
    
    private var gridButtons: some View {
            LazyVGrid(columns: columns) {
                GridRow(imageName: "airtime", title: "Data, Calls, SMS & Airtime")
                GridRow(imageName: "basket", title: "Lipa na M-PESA")
                GridRow(imageName: "chart", title: "My Usage")
                GridRow(imageName: "homeRow", title: "Home Internet")
                GridRow(imageName: "giftRow", title: "Tunikiwa offers")
                GridRow(imageName: "call", title: "Airtime Top up")
                GridRow(imageName: "pot", title: "Bonga")
                GridRow(imageName: "hook", title: "S-Hook Bundles")
            }
            .padding(.top, 12)
    }
    private var storyViews: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 26) {
                StoryView(imageName: "rocket", title: "Updates")
                StoryView(imageName: "forYouu", title: "For You")
                StoryView(imageName: "web", title: "Web Only")
                StoryView(imageName: "explore", title: "Explore")
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .scrollIndicators(.hidden)
    }
    
    private var imageSlidesButtons: some View {
        HStack {
            ImageCarousel()
            VStack(spacing: 25) {
                GridRow(imageName: "girl", title: "Ask Zuri", subtitle: "Get help")
                GridRow(imageName: "send-money", title: "Send Money")
            }
        }
        .frame(height: 200)
    }
}
