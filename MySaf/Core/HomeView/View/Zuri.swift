//
//  Zuri.swift
//  MySaf
//
//  Created by Muktar Hussein on 18/05/2024.
//
// gemini api Key =

import SwiftUI
import GoogleGenerativeAI
import Combine

struct NetworkUnavailableView: View {
    var body: some View {
        ContentUnavailableView(
            "No Internet Connection",
            systemImage: "wifi.exclamationmark",
            description: Text("Please check your connection and try again.")
        )
    }
}


struct Zuri: View {
    // Access your API key from your on-demand resource .plist file
    // (see "Set up your API key" above)
    // get the api key from google studio ai console
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var networkMonitor: NetworkMonitor
    
    @State private var prompt: String = ""
    @State private var response: String = ""
    @FocusState private var focus: Bool
    @State private var messages: [ChatMessage] = []
    
    
    //    @State var cancellables = Set<AnyCancellable>() <- use this for gpt
    
    // using Gemini
    // NOTE: the app wil crash if the api key is missing - add the .plist file with the api. check api key comments
    let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: APIKey.default)
    
    var body: some View {
        NavigationStack {
            VStack {
                Rectangle()
                    .frame(height: 0.6)
                    .frame(maxWidth: .infinity)
                ScrollView {
                    ZStack {
                        if networkMonitor.isConnected {
                            if messages.isEmpty {
                                VStack(alignment: .center, spacing: 20) {
                                    Image("zuri")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 150, height: 150)
                                        .clipShape(Circle())
                                    
                                    Text("How can I help you today?")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                }
                                .padding(.top, 32)
                                
                            } else {
                                VStack {
                                    ForEach(messages, id: \.id) { message in
                                        HStack(alignment: .bottom, spacing: 10) {
                                            if message.isUser {
                                                Spacer()
                                                Text(message.content)
                                                    .font(.subheadline)
                                                    .padding(8)
                                                    .background(.blue)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                                    .padding(.horizontal)
                                            } else {
                                                Text(message.content)
                                                    .font(.subheadline)
                                                    .padding(8)
                                                    .background(Color.gray.opacity(0.2))
                                                    .cornerRadius(10)
                                                    .padding(.horizontal)
                                                Spacer()
                                            }
                                        }
                                        .padding(.vertical, 4)
                                    }
                                }
                            }
                        } else {
                            NetworkUnavailableView()
                        }
                    }
                }
                .padding(.top, 8)
                
                HStack {
                    TextField("Enter prompt...", text: $prompt) {
                        let currentPrompt = prompt
                        prompt = ""
                        Task {
                            try await gemimiResponse(with: currentPrompt)
                        }
                        focus = false // Hide the keyboard after sending
                    }
                    .padding(8)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                    .focused($focus)
                    
                    
                    Button {
                        //sendPrompt() <- use for gpt
                        let currentPrompt = prompt
                        prompt = ""
                        Task {
                            try await gemimiResponse(with: currentPrompt)
                        }
                        focus = false // Hide the keyboard after sending
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .font(.subheadline)
                            .padding(8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            .navigationTitle("Ask Zuri")
            .navigationBarTitleTextColor(.primary)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                focus = true // Focus the text field when the view appears
            }
        }
    }
    
    // MARK: Uses open ai chatgpt for response
    /*
     func sendPrompt() {
     let myText = ChatMessage(id: UUID().uuidString, content: prompt, dateCreated: Date(), isUser: true)
     messages.append(myText)
     OpenAI.shared.makeCall(prompt: prompt).sink { completion in
     switch completion{
     case .finished:
     print("Success \(completion)")
     case .failure(let error):
     print(error.localizedDescription)
     }
     } receiveValue: { returnedResponse in
     guard let responseText = returnedResponse.choices.first?.text else { return }
     let gptText = ChatMessage(id: UUID().uuidString, content: responseText, dateCreated: Date(), isUser: false)
     messages.append(gptText)
     }
     .store(in: &cancellables)
     
     }
     */
    
    // MARK: Uses google gemini for response
    func gemimiResponse(with prompt: String) async throws {
        let userText = ChatMessage(id: UUID().uuidString, content: prompt, dateCreated: Date(), isUser: true)
        withAnimation(.bouncy) {
            messages.append(userText)
        }
        
        // get api response
        do {
            let response = try await model.generateContent(prompt)
            guard let safeRes = response.text else { return }
            let geminiText = ChatMessage(id: UUID().uuidString, content: safeRes, dateCreated: Date(), isUser: false)
            withAnimation(.easeIn) {
                messages.append(geminiText)
            }
        } catch {
            print("Error in do catch block \(error.localizedDescription)")
        }
    }
}

#Preview {
    Zuri()
}

struct ChatMessage {
    let id: String
    let content: String
    let dateCreated: Date
    let isUser: Bool
}

extension ChatMessage {
    static let sampleMessages: [ChatMessage] = [
        ChatMessage(
            id: UUID().uuidString,
            content: "Message from me ",
            dateCreated: Date(),
            isUser: true
        ),
        ChatMessage(
            id: UUID().uuidString,
            content: "Message from model Message from model Message from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from modelMessage from model ",
            dateCreated: Date(),
            isUser: false
        ),
        ChatMessage(
            id: UUID().uuidString,
            content: "New message from me ",
            dateCreated: Date(),
            isUser: true
        ),
        ChatMessage(
            id: UUID().uuidString,
            content: "New  message from model ",
            dateCreated: Date(),
            isUser: false
        )
    ]
}
