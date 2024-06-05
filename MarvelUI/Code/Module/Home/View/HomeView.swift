//
//  ContentView.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var router: Router
    private var viewModel = HomeViewModel()
    
    @State private var listDecorators: [CharacterListDecorator]?
    @State private var pageNumber: Int = 0
    @State private var showLoading = true
    
    var body: some View {
        ToolbarView()
        if showLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.accentColor))
                .onAppear(perform: bind)
        } else {
            ScrollViewReader { value in
                ScrollView {
                    LazyVStack() {
                        ForEach(listDecorators ?? []) { decorator in
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
                                .onTapGesture {
                                    router.navigateTo(.characterDetail(characterId: decorator.id))
                                }
                                Rectangle()
                                    .fill(Color.accentColor)
                                    .frame(height: 1)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity)
                            .background(.white)
                        }
                        HStack {
                            if pageNumber > 0 {
                                Button(action: {
                                    value.scrollTo(0)
                                    showLoading = true
                                    viewModel.previousPage()
                                }, label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundStyle(.accent)
                                })
                            }
                            Text("\(pageNumber)")
                                .foregroundStyle(.accent)
                            if listDecorators?.count ?? 0 > 49 {
                                Button(action: {
                                    value.scrollTo(0)
                                    showLoading = true
                                    viewModel.nextPage()
                                }, label: {
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.accent)
                                })
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    func bind() {
        viewModel.getState().sink { state in
            switch state {
            case .loading:
                showLoading = true
            case .success(let decorators, let page):
                listDecorators = decorators
                pageNumber = page
                showLoading = false
            }
        }
        .store(in: &viewModel.cancellables)
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(Router())
    }
}
