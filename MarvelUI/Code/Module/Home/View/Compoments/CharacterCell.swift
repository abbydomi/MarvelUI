//
//  CharacterCell.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 6/6/24.
//

import SwiftUI

struct CharacterCell: View {
    @State var decorator: CharacterListDecorator
    
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: decorator.thumbnailURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(4)
                } placeholder: {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.accentColor))
                        .frame(width: 100, height: 100)
                        .padding(4)
                }
                VStack(alignment: .leading){
                    Text(decorator.name)
                        .font(.system(.headline))
                    Text(!decorator.description.isEmpty ? decorator.description : "No description available.")
                        .font(.system(.footnote))
                        .foregroundStyle(.gray)
                }
                Spacer()
                Image(systemName: "chevron.forward")
                    .foregroundStyle(.accent)
                    .padding()
            }
            Rectangle()
                .fill(Color.accentColor)
                .frame(height: 1)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
    }
}
