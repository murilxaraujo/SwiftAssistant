//
//  SourceEditorCommand.swift
//  XGPT
//
//  Created by Murilo Araujo on 12/03/23.
//

import AsyncHTTPClient
import Foundation
import XcodeKit
import OpenAIKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {

    static let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
    let configuration = Configuration(apiKey: "", organization: "")
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        let lines = invocation.buffer.lines
        
        let prompt = invocation.buffer.lines.map { line in
            return "\(line)"
        }.joined(separator: "\n")

        let openAIClient = OpenAIKit.Client(httpClient: SourceEditorCommand.httpClient, configuration: configuration)
        
        Task {
            do {
                let prompts = ["A linguagem de programação usada é Swift. \(prompt)"]
                
                let completion = try await openAIClient.completions.create(
                    model: Model.GPT3.textDavinci002,
                    prompts: prompts,
                    maxTokens: 2048,
                    temperature: 0.5
                )
                
                let resultText = completion.choices.map { choice in
                    choice.text
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    lines.removeAllObjects()
                    lines.addObjects(from: resultText)
                    completionHandler(nil)
                }
            } catch let error {
                completionHandler(error)
            }
        }
    }
}
