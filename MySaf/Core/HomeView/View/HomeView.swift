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
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var delegate
    
    let slideImages: [String] = ["pic1", "pic2", "pic3", "pic4", "pic5"]
    
    
    //    @AppStorage("systemThemeValue") private var systemThemeValue: Int = SchemeType.allCases.first!.rawValue
    @Environment(\.colorScheme) private var colorScheme: ColorScheme // System color scheme
    @Environment(\.scenePhase) private var scenePhase
    @State private var isDarkMode: Bool = false // Updates user preference
    
    @State private var showSearchView: Bool = false
    
    @State private var selectedTheme: ColorScheme? = nil
    
    @State private var showNotifications: Bool = false
    
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    
    @State private var selectedImageIndex: Int = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    // MARK: Green name
                    
                    VStack {
                        HStack {
                            HStack {
                                Image(systemName: colorScheme == .dark ? "moonphase.first.quarter.inverse" : "sun.min")
                                    .imageScale(.large)
                                Text(colorScheme == .dark ? "Dark Mode" : "Light Mode")
                            }
                            .foregroundStyle(.white)
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    // Update selectedTheme directly based on user system
                                    
                                }
                            }
                            
                            
                            Spacer()
                            
                            HStack(spacing: 30) {
                                Image(systemName: "magnifyingglass")
                                    .onTapGesture {
                                        showSearchView.toggle()
                                    }
                                Image(systemName: "bell.badge")
                                    .onTapGesture {
                                        showNotifications.toggle()
                                    }
                                
                            }
                            .foregroundStyle(.white)
                        }
                        .padding(.horizontal)
                        
                        TopView()
                    }
                    .background(colorScheme == .light ? .green : .black)
                    .padding(.bottom, 36)
                    .navigationDestination(isPresented: $showNotifications) {
                        NotificationListView()
                    }
                    
                    
                    ScrollView {
                        // MARK: Story views - has horizontal scroll view
                        storyViews
                        // MARK: Sliding image and two grid rows
                        imageSlidesButtons
                            .padding(.horizontal, 6)
                        // MARK: Start of grid
                        gridButtons
                            .padding(.horizontal, 6)
                        // MARK: Hot deals
                        Text("HOT DEALS")
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                            .padding(.top, 8)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                HotDeals(offer1: "Sh 100 = 2GB, 24 Hr", offer2: "+FREE Gmaps")
                                HotDeals(offer1: "Sh 20 (30 Minutes, 3hrs")
                                HotDeals(offer1: "Sh 20 = 200MB + 10 Mins,", offer2: "1hr")
                                HotDeals(offer1: "Sh 50 (Kredo,", offer2: "125, Midnight")
                                HotDeals(offer1: "Sh 10 = 1024MB", offer2: "TikTok, 1Hr")
                            }
                            .padding(.horizontal, 6)
                        }
                        
                        // MARK: FOR YOU
                        Text("FOR YOU")
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                            .padding(.top, 8)
                        
                        ImageView()
                            .padding(.horizontal, 6)
                        
                        Rectangle()
                            .fill(.clear)
                            .frame(height: 50)
                        
                        
                    }
                    .scrollIndicators(.hidden)
                    .frame(maxHeight: .infinity)
                }
                .frame(maxHeight: .infinity)
                .fullScreenCover(isPresented: $showSearchView, content: {
                    SearchView()
                })
                
                
                if isDarkMode {
                    Rectangle()
                        .fill(.gray)
                        .frame(maxWidth: .infinity)
                        .frame(height: 0.5)
                    //                    .offset(y: -250) // <- return offset to 225 before runninf the app on sim. for some reason it messes the sim
                        .offset(y: -225)
                }
                
                NavigationLink {
                    AccountBalance()
                } label: {
                    balancesButton
                }
                .offset(y: -220)
                //                .offset(y: -245)
            }
            .preferredColorScheme(selectedTheme)
            .onAppear {
                NotificationCenter.default.addObserver(forName: .navigateToNotification, object: nil, queue: .main) { notification in
                    if let url = notification.object as? URL, url.host == "notification" {
                        showNotifications = true
                    }
                }
            }
            .onOpenURL { url in
                guard url.host == "notification" else { return }
                showNotifications = true
            }
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
            .fill(colorScheme == .dark ? Color("buttonColor") : .white)
            .fontWeight(.semibold)
            .frame(width: 250, height: 50)
            .shadow(radius: 5)
            .overlay {
                Text("View my Balances")
                    .font(.headline)
                    .foregroundStyle(.green)
                //                    .background(.white)
            }
    }
    
    private var gridButtons: some View {
        LazyVGrid(columns: columns) {
            NavigationLink {
                Text("hi")
            } label: {
                GridRow(imageName: "airtime", title: "Data, Calls, SMS & Airtime")
            }
            
            GridRow(imageName: "basket", title: "Lipa na M-PESA")
            GridRow(imageName: "chart", title: "My Usage")
            GridRow(imageName: "homeRow", title: "Home Internet")
            GridRow(imageName: "giftRow", title: "Tunikiwa offers")
            GridRow(imageName: "call", title: "Airtime Top up")
            GridRow(imageName: "pot", title: "Bonga")
            GridRow(imageName: "hook", title: "S-Hook Bundles")
        }
        .tint(.primary)
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
                NavigationLink {
                    Zuri()
                } label: {
                    GridRow(imageName: "girl", title: "Ask Zuri", subtitle: "Get help")
                }
                .tint(.primary)
                
                NavigationLink {
                    SendMoney()
                } label: {
                    GridRow(imageName: "send-money", title: "Send Money")
                }
                .tint(.primary)
                
            }
        }
        .frame(height: 200)
    }
}

struct SearchView: View {
    @State private var searchableText: String = ""
    @Environment(\.dismiss) var dismiss
    
    var searchItems: [String] = [
        "About",
        "Airtime Topup",
        "Bill Manager",
        "Bonga",
        "Buy Airtime",
        "Cost Calculator",
        "Data Call Plan",
        "Data Sharing",
        "Data, SMS, Call Plan",
        "E Newspaper",
        "Fuliza",
        "Get PUK",
        "Lipa na Bonga",
        "Lipa na M-PESA",
        "M-PESA Global"
    ]
    
    var body: some View {
        NavigationStack {
            List(searchItems, id: \.self) { search in
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text(search)
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchableText)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "arrow.left")
                        .imageScale(.large)
                        .onTapGesture {
                            dismiss()
                        }
                }
            }
        }
    }
    
}



// Computed property for current theme based on user preference and system color scheme
//    private var currentTheme: String {
//        if isDarkMode {
//            return "Dark" // User preference overrides system color scheme
//        } else {
//            return colorScheme == .light ? "Light" : "Dark"
//        }
//    }

//    @State private var selectedTheme: ColorScheme = .light // Initialize with a default theme

// Use the system color scheme if user preference for dark mode is not set


struct NotificationListView: View {
    @ObservedObject var notificationManager = NotificationManager.shared
    var sortedNotifications: [AppNotification] {
        return notificationManager.notifications.sorted(by: { $0.date > $1.date })
    }
    
    
    var body: some View {
        NavigationView {
            ZStack {
                if sortedNotifications.isEmpty {
                    
                    ContentUnavailableView("No transactions available", systemImage: "doc.questionmark", description: Text("You recent transactions will be displayed here"))
                    
                }else {
                    List(sortedNotifications) { notification in
                        VStack(alignment: .leading) {
                            Text(notification.title)
                                .font(.headline)
                            Text(notification.subtitle)
                                .font(.subheadline)
                            Text(notification.date, style: .date)
                                .font(.caption)
                        }
                    }
                    .listStyle(.plain)
                    
                }
            }
            .navigationTitle("Recent Transactions")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
