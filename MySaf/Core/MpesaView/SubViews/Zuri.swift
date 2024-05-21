//
//  Zuri.swift
//  MySaf
//
//  Created by Muktar Hussein on 18/05/2024.
//
// gemini api Key = 

import SwiftUI
import GoogleGenerativeAI
import UIKit

struct Zuri: View {
    // Access your API key from your on-demand resource .plist file
    // (see "Set up your API key" above)
    // get the api key from google studio ai console
    let model = GenerativeModel(name: "gemini-pro", apiKey: "")
    @Environment(\.colorScheme) var colorScheme
    
    @State private var prompt: String = ""
    @State private var response: String = ""
    @State private var isFetchingResponse: Bool = false
    @FocusState private var focus: Bool
    @State private var isSendPressed: Bool = false
    @State private var messages: [Message] = []
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ScrollViewReader { reader in
                        ForEach(messages) { message in
                            HStack {
                                if message.isUser {
                                    Spacer()
                                    Text(message.text)
                                        .foregroundStyle(.white)
                                        .padding(10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(.blue)
                                        )
                                } else {
                                    Text(message.text)
                                        .padding(10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(colorScheme == .dark ? Color("buttonColor") : .gray)
                                        )
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                        }
                        .onChange(of: messages.count) { _ in
                            withAnimation {
                                reader.scrollTo(messages.last?.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                TextField("Ask Zuri", text: $prompt)
                    .padding(10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(lineWidth: 1.0)
                    }
                    .onSubmit {
                        let userMessage = Message(text: prompt, isUser: true)
                        messages.append(userMessage)
                        self.prompt = ""
                        
                        Task {
                            do {
                                try await fetchResponse(prompt: prompt)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    .focused($focus)
            }
            .padding(.horizontal)
            .navigationTitle("Ask Zuri")
            .onAppear {
                focus = true
            }
        }
//        .toolbar(.hidden, for: .tabBar)
    }
    
    func fetchResponse(prompt: String) async throws {
        let generatedResponse = try await model.generateContent(prompt)
        if let text = generatedResponse.text {
            print(text)
            let appRes = Message(text: text, isUser: false)
            messages.append(appRes)
        }
    }
}

#Preview {
    Zuri()
}


struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}
