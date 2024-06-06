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
    var viewModel: CharacterDetailViewModel
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        if showLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.accentColor))
                .onAppear(perform: bind)
                
        } else {
            VStack {
                Text("Character ID")
                Text("\(decorator?.id ?? 0)")
            }
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
