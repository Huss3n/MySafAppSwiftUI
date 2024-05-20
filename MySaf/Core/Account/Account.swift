//
//  Account.swift
//  MySaf
//
//  Created by Muktar Hussein on 20/05/2024.
//

import SwiftUI

struct Account: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var logout: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 20) {
                        // MARK: SIM details
                        HStack {
                            VStack(alignment: .leading) {
                                Text("SIM Details")
                                    .fontWeight(.semibold)
                                Text("View and verify your sim details")
                                    .font(.headline)
                                    .foregroundStyle(.green)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            Image("shield")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 3)
                                .fill(colorScheme == .light ? .white : Color("buttonColor"))
                                .shadow(radius: 2)
                        )
                        .padding(.top, 8)
                        
                        // MARK: NAME
                        VStack(spacing: 20) {
                            HStack(alignment: .top) {
                                Text("HM")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                    .padding()
                                    .background(
                                        Circle()
                                            .fill(.green)
                                    )
                                
                                Text("Hussein Muktar")
                                    .font(.headline)
                                    .foregroundStyle(.gray)
                                    .fontWeight(.bold)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Rectangle()
                                .fill(.gray)
                                .frame(height: 1)
                            
                            HStack(spacing: 18) {
                                VStack(alignment: .center, spacing: 10) {
                                    Text("Phone No.")
                                        .fontWeight(.light)
                                    Text("0712345678")
                                        .font(.caption)
                                }
                                
                                Rectangle()
                                    .frame(width: 2, height: 25)
                                    .padding(.horizontal, 20)
                                
                                VStack(alignment: .center, spacing: 10) {
                                    Text("Status")
                                        .fontWeight(.light)
                                    Text("Active")
                                        .font(.caption)
                                }
                                
                                Rectangle()
                                    .frame(width: 2, height: 25)
                                    .padding(.horizontal, 20)
                                
                                VStack(alignment: .center, spacing: 10) {
                                    Text("Tariff")
                                        .fontWeight(.light)
                                    Text("Prepaid")
                                        .font(.caption)
                                }
                            }
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            .fontWeight(.medium)
                            
                           
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 3)
                                .fill(colorScheme == .light ? .white : Color("buttonColor"))
                                .shadow(radius: 2)
                        )
                        
                        // MARK: Quick action buttons
                        VStack(spacing: 20) {
                            Text("Quick Account Actions")
                                .foregroundStyle(.gray)
                                .fontWeight(.semibold)
                            
                            Rectangle()
                                .fill(.gray)
                                .frame(height: 1)
                            
                            
                            HStack(spacing: 60) {
                                VStack {
                                    Image("simcard")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                    Text("PUK")
                                }
                                
                                
                                VStack {
                                    Image("airtime")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                    Text("Sambaza")
                                }
                                
                                
                                VStack {
                                    Image("fraud")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                    Text("Report Fraud")
                                }
                                
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 3)
                                .fill(colorScheme == .light ? .white : Color("buttonColor"))
                                .shadow(radius: 2)
                        )
                        
                        // MARK: List
    //                    ScrollView {
                            VStack(spacing: 40) {
                                ListComponent(imageName: "chart", title: "Data & Airtime Usage")
                                 ListComponent(imageName: "subscriptions", title: "My Subscriptions")
                                 ListComponent(imageName: "e-sim", title: "Re1uest e-Sim")
                                 ListComponent(imageName: "simcard", title: "SIM Management")
                                ListComponent(imageName: "settings", title: "App Settings")
                                ListComponent(imageName: "rateus", title: "SIM Management")
                                ListComponent(imageName: "info", title: "About mySafaricom")
                            }
                            .padding(.horizontal, -14)
                           
                            Rectangle()
                                .fill(.clear)
                                .frame(height: 60)
    //                    }
    //                    .scrollIndicators(.hidden)
                        
                    }
                    .padding(.horizontal, 8)
                }
                .scrollIndicators(.hidden)
            }
            .alert("Logout", isPresented: $logout) {
                Button("Cancel", role: .cancel, action: {})
                Button("Ok", role: .destructive, action: { logout.toggle() })
            }message: {
                Text("Are you sure you want to logout?")
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 2)
            .offset(y: 40)
            
            Rectangle()
                .fill(colorScheme == .light ? .green : Color("buttonColor"))
                .frame(maxWidth: .infinity)
                .frame(height: 93)
                .overlay {
                    HStack(alignment: .bottom) {
                        Text("Account")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .offset(x: 30)
                        
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .imageScale(.medium)
                            .foregroundStyle(.white)
                            .padding(.trailing)
                            .onTapGesture {
                                logout.toggle()
                            }
                    }
                    .offset(y: 20)
                }
                .ignoresSafeArea()
            
        }
    }
}

#Preview {
//    ListComponent(imageName: "e-sim", title: "Esim")
    Account()
}

struct ListComponent: View {
    @Environment(\.colorScheme) var colorScheme
    var imageName: String
    var title: String
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
           Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.leading, 8)
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "greaterthan")
                .padding(.trailing, 6)
        }
        .background (
            RoundedRectangle(cornerRadius: 8)
                .fill(colorScheme == .light ? .white : Color("buttonColor"))
                .frame(height: 60)
                .shadow(radius: 1)
        )
        .padding(.horizontal)
    }
}
