//
//  Categories.swift
//  MySaf
//
//  Created by Muktar Hussein on 20/05/2024.
//

import SwiftUI

struct Categories: View {
    @Environment(\.colorScheme) var colorScheme
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: nil, alignment: nil),
        GridItem(.flexible(), spacing: nil, alignment: nil)
    ]
    var body: some View {
        ZStack(alignment: .top) {
         
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Browse Categories")
                        .foregroundStyle(.gray)
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    LazyVGrid(columns: columns,
                              content: {
                        CatComponent(
                            title: "Games",
                            subtitle: "Play unlimited games",
                            image: "gamecontroller",
                            color: .orange
                        )
                        
                        CatComponent(
                            title: "Newspapers",
                            subtitle: "Read your favourite paper",
                            image: "book",
                            color: .green
                        )
                        
                        CatComponent(
                            title: "News",
                            subtitle: "Get latest stories",
                            image: "newspaper",
                            color: .purple
                        )
                        
                        CatComponent(
                            title: "Education",
                            subtitle: "Shine in all subjects",
                            image: "graduationcap",
                            color: .blue
                        )
                        
                        CatComponent(
                            title: "Jobs",
                            subtitle: "Find your dream job",
                            image: "briefcase",
                            color: .yellow
                        )
                        
                        CatComponent(
                            title: "Baze Tv",
                            subtitle: "View local shows",
                            image: "tv",
                            color: .red
                        )
                        
                        CatComponent(
                            title: "Masoko",
                            subtitle: "Shop, we deliver",
                            image: "cart",
                            color: .cyan
                        )
                        
                        CatComponent(
                            title: "Find a Shop",
                            subtitle: "Safaricom shops near you",
                            image: "pin",
                            color: .brown
                        )
                    })
                    
                    Text("FOR YOU")
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                        .padding(.top, 8)
                    
                    ImageView()
                    
                    Text("Hot Deals")
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)
                        .padding(.top, 8)
                    
                    ImageView()
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 50)
                }
                .offset(y:40)
                .padding(.horizontal, 6)
            }
            
            
            
            
            
            
            
            Rectangle()
                .fill(colorScheme == .light ? .green : Color("buttonColor"))
                .frame(maxWidth: .infinity)
                .frame(height: 93)
                .overlay {
                    HStack(alignment: .bottom) {
                        Text("Discover")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .offset(y: 20)
                }
                .ignoresSafeArea()
        }
    }
}

#Preview {
        Categories()
//    CatComponent()
//        .padding()
}

struct CatComponent: View {
    var title: String = "Games"
    var subtitle: String = "Play unlimited games"
    var image: String = "gamecontroller"
    var color: Color = .orange
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
            Text(subtitle)
                .font(.caption)
                .fontWeight(.medium)
                .foregroundStyle(.white)
            
            Image(systemName: image)
                .font(.caption)
                .foregroundStyle(color)
                .padding(6)
                .background(
                    Circle()
                        .fill(.white)
                )
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
        )
        
    }
}
