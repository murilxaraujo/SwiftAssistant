//
//  TokenViewModel.swift
//  XcodeGPT
//
//  Created by Murilo Araujo on 20/03/23.
//

import SwiftUI
import SwiftAssistantCore

class TokenViewModel: ObservableObject {
    @Published var tokenString = ""

    private let tokenManager = TokenManager()
    
    func saveToken() {
        if tokenString.isEmpty { return }
        tokenManager.set(token: tokenString)
    }
}

