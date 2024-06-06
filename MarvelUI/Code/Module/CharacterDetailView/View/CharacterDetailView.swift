//
//  CharacterDetailView.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @EnvironmentObject var router: Router
    @State private var showLoading = true
    @State private var decorator: CharacterDetailDecorator?
    @State private var comics: [CharacterDetailComicDecorator] = []
    @State var viewModel: CharacterDetailViewModel
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if showLoading {
            ZStack {
                Color.accentColor
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .onAppear(perform: bind)
            }
            
                
        } else {
            VStack(spacing: 0) {
                ScrollView {
                    AsyncImage(url: decorator?.thumbnailURL) { image in
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
                    if let decorator = decorator {
                        CharacterDetailDataView(decorator: decorator)
                    }
                        
                    if !comics.isEmpty {
                        ComicCarousel(comics: $comics, decorator: $decorator)
                            .padding(.horizontal, 40)
                    }
                }
                .ignoresSafeArea()
                
                Spacer()
                Button {
                    router.goBack()
                } label: {
                    Text("Go back")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .clipShape(.capsule)
                        .padding(.horizontal)
                }

            }
            .background(Color.accentColor)
            .navigationBarBackButtonHidden()
        }
       
    }
    
    func bind() {
        viewModel.getState().sink { state in
            switch state {
            case .loading: 
                showLoading = true
            case .success(let decorator):
                self.decorator = decorator
                showLoading = false
            case .comics(let comics):
                self.comics = comics
                showLoading = false
            }
        }
        .store(in: &viewModel.cancellables)
    }
}

struct CharacterDetailDataView: View {
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

#Preview {
    NavigationStack {
        CharacterDetailView(viewModel: CharacterDetailViewModel(characterID: 1010795))
    }
}
