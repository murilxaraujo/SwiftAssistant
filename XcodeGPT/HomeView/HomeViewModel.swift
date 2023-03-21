//
//  HomeViewModel.swift
//  XcodeGPT
//
//  Created by Murilo Araujo on 14/03/23.
//

import Foundation
import SwiftAssistantCore

class HomeViewModel: ObservableObject {
    @Published var token: String?
    @Published var isPresentingToken = false
    
    private let tokenManager = TokenManager()
    
    func getData() {
        token = tokenManager.getToken()
    }
}
