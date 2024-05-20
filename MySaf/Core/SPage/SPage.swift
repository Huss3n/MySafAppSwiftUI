//
//  SPage.swift
//  MySaf
//
//  Created by Muktar Hussein on 20/05/2024.
//

import SwiftUI

struct SPage: View {
    @State private var showEdit: Bool = false
    var body: some View {
        ZStack {
            Color.primary.opacity(0.24)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image("receipt")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(10)
                        .background(
                            Circle()
                                .fill(.green.opacity(0.2))
                        )
                    
                    
                    Text("Data, Calls and SMS")
                }
                
                HStack {
                    Image("airtime")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(10)
                        .background(
                            Circle()
                                .fill(.green.opacity(0.2))
                        )
                    
                    Text("Buy Airtime")
                }
                
                HStack {
                    Image("receipt")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(10)
                        .background(
                            Circle()
                                .fill(.green.opacity(0.2))
                        )
                    
                    Text("Bill Manager")
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .fullScreenCover(isPresented: $showEdit) {
                NavigationStack {
                    VStack {
                        Text("Edit Shortcuts")
                            .font(.title2)
                    }
                    .navigationTitle("Edit shortcuts")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Image(systemName: "arrow.left")
                                .onTapGesture {
                                    withAnimation(.bouncy) {
                                        showEdit.toggle()
                                    }
                                }
                        }
                    }
                }
            }
            .offset(y: -30)
            
            HStack {
                Text("Edit Favourites")
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Image(systemName: "pencil")
                    .font(.title2.bold())
                    .foregroundStyle(.red)
                    .padding(8)
                    .background {
                        Circle()
                            .fill(.white)
                    }
            }
            .padding(.trailing, 4)
            .offset(x: 105, y: -250)
            .onTapGesture {
                withAnimation(.bouncy) {
                    showEdit.toggle()
                }
            }
        }
    }
}

#Preview {
    SPage()
}
