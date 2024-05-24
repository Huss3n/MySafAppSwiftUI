//
//  OpenAI.swift
//  MySaf
//
//  Created by Muktar Hussein on 21/05/2024.
//

import Foundation
import Alamofire
import Combine


final class OpenAI {
    static let shared = OpenAI()
    
    let baseURL = "https://api.openai.com/v1/"
    init() { }
    
    func makeCall(prompt: String) -> AnyPublisher<OpenAICompletionsResponse, Error> {
        let body = OpenAICompletionsBody(model: "gpt-3.5-turbo", prompt: prompt, temprature: 0.7)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer ",
            "Content-Type": "application/json"
        ]
        return Future { [weak self] promise in
            guard let self = self else { return }
            AF.request(baseURL + "completions" , method: .post, parameters: body, encoder: .json, headers: headers)
                .validate()
                .responseDecodable(of: OpenAICompletionsResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print("API Response \(result)")
                        promise(.success(result))
                    case .failure(let error):
                        if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                            print("Response data: \(jsonString)")
                        }
                        print("API Error: \(error.localizedDescription)")
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}

struct OpenAICompletionsBody: Encodable {
    let model: String
    let prompt: String
    let temprature: Float?
}

struct OpenAICompletionsResponse: Decodable {
    let choices: [OpenAICompletionsChoice]
    let created: Int
    let id: String
    let model: String
    let object: String
    let usage: OpenAICompletionsUsage
}

struct OpenAICompletionsChoice: Decodable {
    let finish_reason: String
    let index: Int
    let logprobs: String?
    let text: String
}

struct OpenAICompletionsUsage: Decodable {
    let completion_tokens: Int
    let prompt_tokens: Int
    let total_tokens: Int
}
