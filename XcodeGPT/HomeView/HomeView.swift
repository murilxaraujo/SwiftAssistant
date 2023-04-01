//
//  ContentView.swift
//  XcodeGPT
//
//  Created by Murilo Araujo on 12/03/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Olá, dev! 😁")
                    .font(.title)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.token != nil ?"Estou pronta para te ajudar. No menu editor do seu Xcode selecione SwiftAssistant" : "Configure seu token abaixo para continuar")
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                    .padding(.trailing, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }.background {
                Color.white.opacity(0.1)
            }
            HStack {
                MenuCard(title: "Token",
                         iconName: "key",
                         description: viewModel.token ?? "Pendente",
                         iconColor: viewModel.token != nil ? .green : .red)
                .onTapGesture {
                    viewModel.isPresentingToken = true
                }
                MenuCard(title: "Model", iconName: "shippingbox.fill", description: "GPT3.5-Turbo")
                MenuCard(title: "Treinar", iconName: "figure.strengthtraining.functional", description: "Em breve...")
            }
            Spacer()
            HStack {
                Text("Powered by")
                Image("OpenAI_Logo.svg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 20)
            }.opacity(0.5)
                .padding()
        }.navigationTitle("SwiftAssistant")
            .sheet(isPresented: $viewModel.isPresentingToken, onDismiss: {
                viewModel.getData()
            }, content: {
                TokenView(isShowing: $viewModel.isPresentingToken)
            })
            .onAppear {
                viewModel.getData()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
