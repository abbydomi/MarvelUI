//
//  CharacterDetailView.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import SwiftUI

struct CharacterDetailView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject var router: Router
    @State private var showLoading = true
    @State private var decorator: CharacterDetailDecorator?
    @State private var comics: [CharacterDetailComicDecorator] = []
    @State var viewModel: CharacterDetailViewModel
    
    // MARK: - Lifecycle
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
    }
    // MARK: - View
    
    var body: some View {
        if showLoading {
            ZStack {
                LoaderView(backgroundColor: .accent, spinnerColor: .white)
                    .onAppear(perform: bind)
            }
        } else {
            VStack(spacing: 0) {
                ScrollView {
                    if let decorator = decorator {
                        CharacterBanner(decorator: decorator)
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
    // MARK: - Bind to ViewModel
    
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
    // MARK: - Preview

#Preview {
    NavigationStack {
        CharacterDetailView(viewModel: CharacterDetailViewModel(characterID: 1010795))
    }
}
