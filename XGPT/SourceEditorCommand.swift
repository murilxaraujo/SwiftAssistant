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
import SwiftAssistantCore


enum SAErrors: Error {
    case tokenMissing
}

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    static let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)

    let tokenManager = TokenManager()
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        
        let lines = invocation.buffer.lines
        
        let prompt = invocation.buffer.lines.map { line in
            return "\(line)"
        }.joined(separator: "\n")

        guard let token = tokenManager.getToken() else {
            completionHandler(SAErrors.tokenMissing)
            return
        }
        
        let configuration = Configuration(apiKey: token, organization: "")
        
        let openAIClient = OpenAIKit.Client(httpClient: SourceEditorCommand.httpClient, configuration: configuration)
        
        Task {
            do {
                let modelEngine = getModelEngine(withClient: openAIClient)
                
                let resultText = try await modelEngine.getResponse(from: prompt)
                
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
    
    func getModelEngine(withClient client: OpenAIKit.Client) -> ModelEngine {
        return GPT3dot5TurboEngine(openAIClient: client)
    }
}
