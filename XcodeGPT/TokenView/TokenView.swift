//
//  TokenView.swift
//  XcodeGPT
//
//  Created by Murilo Araujo on 20/03/23.
//

import SwiftUI

struct TokenView: View {
    @StateObject var viewModel = TokenViewModel()
    @Binding var isShowing: Bool
    var body: some View {
        VStack {
            Image(systemName: "key")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .padding()
            Text("Insira o seu token OpenAI").font(.headline)
            TextField("Token", text: $viewModel.tokenString)
            Button("Salvar") {
                viewModel.saveToken()
                isShowing = false
            }.buttonStyle(.bordered)
        }.frame(maxWidth: 300).padding()
        
    }
}
