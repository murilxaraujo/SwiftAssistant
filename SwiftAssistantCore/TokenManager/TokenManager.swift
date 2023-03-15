//
//  TokenManager.swift
//  SwiftAssistantCore
//
//  Created by Murilo Araujo on 14/03/23.
//

import Foundation

public class TokenManager {
    let keychainHelper = KeychainHelper.standard
    
    enum Constants {
        static let account = "dev.muriloaraujo.xgpt"
        static let service = "token"
    }
    
    public func getToken() -> String? {
        return keychainHelper.read(service: Constants.service, account: Constants.account, type: String.self)
    }
    
    public func set(token: String) {
        keychainHelper.save(token, service: Constants.service, account: Constants.account)
    }
    
    public init() {}
}
