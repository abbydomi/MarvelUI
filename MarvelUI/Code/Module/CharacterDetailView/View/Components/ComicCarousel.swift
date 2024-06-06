//
//  ComicCarousel.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 6/6/24.
//

import SwiftUI

struct ComicCarousel: View {
    
    @EnvironmentObject var router: Router
    @Binding var comics: [CharacterDetailComicDecorator]
    @Binding var decorator: CharacterDetailDecorator?
    
    var body: some View {
        VStack {
            HStack {
                Text("Comics")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .fontDesign(.rounded)
                    .bold()
                Spacer()
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(comics) { comic in
                        VStack {
                            AsyncImage(url: comic.imageURL) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                            } placeholder: {
                                ProgressView()
                                    .progressViewStyle(.circular)
                                    .foregroundStyle(.white)
                            }
                            if let comicURL = comic.comicURL {
                                Button {
                                    router.navigateTo(.webView(url: comicURL))
                                } label: {
                                    Text("More info")
                                        .padding()
                                        .background(.white)
                                        .clipShape(.capsule)
                                        .foregroundColor(.accent)
                                }
                            }
                            
                        }
                        .frame(width: 200)
                    }
                    if let comicURL = decorator?.comicURL {
                        Button(action: {
                            router.navigateTo(.webView(url: comicURL))
                        }, label: {
                            Text("More comics")
                                .foregroundStyle(.accent)
                                .padding()
                                .background(Color.white)
                                .clipShape(.capsule)
                        })
                        .padding()
                    }
                }
            }
        }
    }
}
