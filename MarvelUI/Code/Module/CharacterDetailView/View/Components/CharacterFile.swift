//
//  CharacterFile.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 6/6/24.
//

import SwiftUI

struct CharacterFile: View {
    @EnvironmentObject var router: Router
    @State var decorator: CharacterDetailDecorator
    
    var body: some View {
        VStack {
            Text(decorator.name)
                .padding(.horizontal)
                .fontDesign(.rounded)
                .bold()
                .font(.system(size: 56))
                .minimumScaleFactor(0.1)
                .lineLimit(1)
                .foregroundStyle(.white)
            Text("Last modified: \(decorator.modified) days ago.")
                .font(.footnote)
                .foregroundStyle(.white)
            Text(!decorator.description.isEmpty ? decorator.description : "No description available.")
                .padding()
                .foregroundColor(.white)
        }
        .padding(.horizontal, 25)
    }
}
