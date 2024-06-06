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
                        CharacterFile(decorator: decorator)
                    }
                        
                    if !comics.isEmpty {
                        ComicCarousel(comics: $comics, decorator: $decorator)
                            .padding(.horizontal, 40)
                    }
                }
                .ignoresSafeArea()
                Spacer()
                ButtonGoBackPrimary()
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

#Preview {
    NavigationStack {
        CharacterDetailView(viewModel: CharacterDetailViewModel(characterID: 1010795))
    }
}
