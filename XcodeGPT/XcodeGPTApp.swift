//
//  XcodeGPTApp.swift
//  XcodeGPT
//
//  Created by Murilo Araujo on 12/03/23.
//

import SwiftUI

@main
struct XcodeGPTApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .frame(minWidth: 600, minHeight: 500)
        }
    }
}
