//
//  HomeViewModel.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let state: CurrentValueSubject<HomeState, Never>  = .init(.loading)
    private let homeDataManager = HomeDataManager()
    private var offset = 0
    private var page = 0
    private var orderSelection = OrderSelection.nameAscending
    private var searchName = ""
    
    var cancellables = Set<AnyCancellable>()
    
    enum Constants {
        static let limit = 50
    }
    
    // MARK: - Lifecycle
    
    init() {
        getCharacters(offset: 0)
    }
    
    func getState() -> AnyPublisher<HomeState, Never> {
        state.eraseToAnyPublisher()
    }
    
    func nextPage() {
        state.send(.loading)
        page += 1
        offset = page * Constants.limit
        getCharacters(offset: offset)
    }
    
    func previousPage() {
        state.send(.loading)
        page -= 1
        offset = page * Constants.limit
        getCharacters(offset: offset)
    }
    
    func searchCharacter(name: String, orderBy: OrderSelection) {
        print("search start")
        state.send(.loading)
        offset = 0
        page = 0
        getCharacters(offset: 0, searchQuery: name, orderBy: orderBy)
    }
}

// MARK: - Methods

private extension HomeViewModel {
    
    private func getCharacters(offset: Int, searchQuery: String = "", orderBy: OrderSelection = OrderSelection.nameAscending) {
        Task {
            do {
                let characterListDecorators = try await homeDataManager.getCharacters(limit: Constants.limit,
                                                                                      offset: offset,
                                                                                      name: searchQuery,
                                                                                      orderBy: orderBy)
                print("send search")
                state.send(.success(characterListDecorators, page))
            } catch NetworkError.badResponse {
                print("bad response")
            } catch NetworkError.needsAuth {
                print("auth")
            } catch NetworkError.notFound {
                print("not found")
            } catch NetworkError.serviceDown {
                print("service down")
            } catch {
                print(String(describing: error))
            }
        }
        
    }
}

// MARK: - Home States

enum HomeState {
    case loading
    case success([CharacterListDecorator], Int)
}

enum OrderSelection: String, Codable, Identifiable, CaseIterable  {
    var id: Self { self }
    
    case nameAscending = "Name A-Z"
    case nameDescending = "Name Z-A"
    case modifiedAscending = "Modified by Oldest"
    case modifiedDescending = "Modified by Latest"
}
