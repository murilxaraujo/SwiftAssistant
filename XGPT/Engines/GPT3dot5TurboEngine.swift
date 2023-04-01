//
//  GPT3dot5TurboEngine.swift
//  XcodeGPT
//
//  Created by Murilo Araujo on 01/04/23.
//

import Foundation
import OpenAIKit

class GPT3dot5TurboEngine: ModelEngine {
    let openAIClient: OpenAIKit.Client
    var isCodeLine = false
    
    init(openAIClient: OpenAIKit.Client) {
        self.openAIClient = openAIClient
    }
    
    func getResponse(from queryString: String) async throws -> [String] {
        do {
            let completion = try await openAIClient.chats.create(model: Model.GPT3.gpt3_5Turbo,
                                                                 messages: [
                Chat.Message(role: "system", content: "Você é um ajudante de programador."),
                Chat.Message(role: "system", content: "A linguagem de programação usada é Swift."),
                Chat.Message(role: "user", content: queryString)
                             ], maxTokens: 2048)
            
            var resultText: [String] = []
            
            completion.choices.forEach { choice in
                let lineContent = choice.message.content.split(separator: "\n")
                
                for line in lineContent {
                    let lineString = String(line)
                    
                    if lineString.contains("```swift") {
                        isCodeLine = true
                        continue
                    }
                    
                    if lineString.contains("```"), !lineString.contains("```swift") {
                        isCodeLine = false
                        continue
                    }
                    
                    resultText.append(isCodeLine ? lineString : "// \(lineString)")
                }
                
            }
            
            return resultText.map {"\($0)\n" }
        } catch {
            throw error
        }
    }
}
