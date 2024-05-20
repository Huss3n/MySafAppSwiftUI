//
//  AccountBalance.swift
//  MySaf
//
//  Created by Muktar Hussein on 17/05/2024.
//

import SwiftUI

struct AccountBalance: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    BalanceRow(
                        imageName: "airtime",
                        title: "Airtime",
                        value: "KES 76.4",
                        height: 250,
                        subtitle1: "Prepaid Balance",
                        title1Value: "0",
                        subtitle2: "Expiry",
                        title2Value: "2037-01-01",
                        subtitle3: "Tax Discount",
                        title3Value: "0",
                        subtitle4: "Okoa Jahazi",
                        title4Value: "0",
                        subtitle5: "Expiry",
                        title5Value: "2025-05-18",
                        button1Text: "Sambaza",
                        button2Text: "Top Up"
                    )
                    
                    BalanceRow(
                        imageName: "data",
                        title: "Data",
                        value: "4,329 MBs",
                        height: 250,
                        subtitle1: "Daily Data",
                        title1Value: "0",
                        subtitle2: "Expiry",
                        title2Value: "2037-01-01 18:59",
                        subtitle3: "Free WhatsaApp with Expiry",
                        title3Value: "399",
                        subtitle4: "Expiry",
                        title4Value: "2024-05017 18:59",
                        button1Text: "Share/Request Data",
                        button2Text: "Buy Data"
                    )
                    
                    BalanceRow(
                        imageName: "sms",
                        title: "SMS",
                        value: "533 Items",
                        height: 180,
                        subtitle1: "Daily SMS",
                        title1Value: "558",
                        subtitle2: "Expiry",
                        title2Value: "2037-01-01",
                        button1Text: "Button 1"
                    )
                    
                    BalanceRow(imageName: "call", title: "Voice", value: "208.4 Minutes")
                    
                    BalanceRow(imageName: "sms", title: "SMS", value: "243 Items")
                    
                    BalanceRow(imageName: "pot", title: "Bonga", value: "18,423 Points")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .navigationTitle("My Account Balances")
                .navigationBarTitleDisplayMode(.inline)
                .padding(.horizontal, 6)
                .padding(4)
            }
        }
    }
}

#Preview {
    AccountBalance()
}
