//
//  ModelEngine.swift
//  XcodeGPT
//
//  Created by Murilo Araujo on 01/04/23.
//

import Foundation

protocol ModelEngine {
    func getResponse(from queryString: String) async throws -> [String]
}
