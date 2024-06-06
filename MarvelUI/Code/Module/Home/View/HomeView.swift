//
//  ContentView.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    
    @EnvironmentObject var router: Router
    @State private var viewModel = HomeViewModel()
    @State private var listDecorators: [CharacterListDecorator]?
    @State private var pageNumber: Int = 0
    @State private var showLoading = true
    @State private var searchText = ""
    @State private var orderSelection = OrderSelection.nameAscending
    @State private var showError = false
    @State private var errorMessage = ""
    
    // MARK: - View
    
    var body: some View {
        ToolbarView()
        if showLoading {
            LoaderView()
                .onAppear(perform: bind)
        } else {
            VStack {
                SearchBar(viewModel: $viewModel, orderSelection: $orderSelection, searchText: $searchText)
                ScrollViewReader { value in
                    ScrollView {
                        LazyVStack() {
                            ForEach(listDecorators ?? []) { decorator in
                                CharacterCell(decorator: decorator)
                                    .onTapGesture {
                                        router.navigateTo(.characterDetail(characterId: decorator.id))
                                    }
                            }
                            PageControl(viewModel: $viewModel, pageNumber: $pageNumber, showLoading: $showLoading, listDecorators: $listDecorators)
                                .onTapGesture {
                                    value.scrollTo(0)
                                }
                        }
                    }
                }
            }
        }
    }
}
// MARK: - Private Methods

private extension HomeView {
        
    func bind() {
        viewModel.getState().sink { state in
            switch state {
            case .loading:
                showLoading = true
            case .success(let decorators, let page):
                listDecorators = decorators
                pageNumber = page + 1
                showLoading = false
            case .failure(let error):
                router.handleError(error)
            }
        }
        .store(in: &viewModel.cancellables)
    }
    
    
}

//MARK: - Previews

#Preview {
    NavigationStack {
        HomeView()
    }
    .environmentObject(Router())
}
