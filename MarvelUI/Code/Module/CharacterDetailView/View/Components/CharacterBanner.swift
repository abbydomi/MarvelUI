//
//  CharacterBanner.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 6/6/24.
//

import SwiftUI

struct CharacterBanner: View {
    @State var decorator: CharacterDetailDecorator
    
    var body: some View {
        AsyncImage(url: decorator.thumbnailURL) { image in
            ZStack {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(LinearGradient(colors: [.accent, .clear], startPoint: .bottom, endPoint: .center))
                        .frame(height: 40)
                }
            }
            .frame(height: UIScreen.main.bounds.height / 3)
        } placeholder: {
            ZStack {
                Color.gray
                    .frame(height: UIScreen.main.bounds.height / 3)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            }
        }
    }
}
