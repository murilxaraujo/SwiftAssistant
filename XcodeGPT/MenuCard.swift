//
//  MenuCard.swift
//  XcodeGPT
//
//  Created by Murilo Araujo on 14/03/23.
//

import SwiftUI

struct MenuCard: View {
    let title: String
    let iconName: String
    let description: String
    var iconColor = Color.blue
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2)
                Spacer()
                Image(systemName: iconName)
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .background {
                        iconColor
                    }
                    .cornerRadius(15)
            }.padding()
            HStack{
                Text(description)
                    .font(.caption)
                    .padding()
                Spacer()
            }
        }.frame(width: 150, height: 110)
            .background(content: {
                Color.white.opacity(0.1)
            })
            .cornerRadius(10)
            .padding()
        
    }
}

struct MenuCard_Previews: PreviewProvider {
    static var previews: some View {
        MenuCard(title: "Titulo", iconName: "plus", description: "description")
    }
}
