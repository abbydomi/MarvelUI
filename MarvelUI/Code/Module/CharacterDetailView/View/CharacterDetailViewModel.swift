//
//  CharacterDetailViewModel.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation
import Combine

class CharacterDetailViewModel {
    
    private let state: CurrentValueSubject<CharacterDetailState, Never>  = .init(.loading)
    private let characterDataManager = CharacterDetailDataManager()
    
    var cancellables = Set<AnyCancellable>()
    
    init(characterID: Int) {
        getCharacter(id: characterID)
        getComics(id: characterID)
    }
    
    func getState() -> AnyPublisher<CharacterDetailState, Never> {
        state.eraseToAnyPublisher()
    }
}

private extension CharacterDetailViewModel {
    
    func getCharacter(id: Int) {
        Task {
            do {
                let decorator = try await characterDataManager.getCharacter(id: id)
                state.send(.success(decorator))
            } catch NetworkError.badResponse {
                state.send(.failure(.badResponse))
            } catch NetworkError.needsAuth {
                state.send(.failure(.needsAuth))
            } catch NetworkError.notFound {
                state.send(.failure(.notFound))
            } catch NetworkError.serviceDown {
                state.send(.failure(.serviceDown))
            } catch {
                state.send(.failure(.unknown))
            }
        }
    }
    
    func getComics(id: Int) {
        Task {
            do {
                let comics = try await characterDataManager.getComicImagesFromCharacter(id: id)
                print(comics)
                state.send(.comics(comics))
            } catch NetworkError.badResponse {
                state.send(.failure(.badResponse))
            } catch NetworkError.needsAuth {
                state.send(.failure(.needsAuth))
            } catch NetworkError.notFound {
                state.send(.failure(.notFound))
            } catch NetworkError.serviceDown {
                state.send(.failure(.serviceDown))
            } catch {
                state.send(.failure(.unknown))
            }
        }
    }
}

enum CharacterDetailState {
    case loading
    case success(CharacterDetailDecorator)
    case comics([CharacterDetailComicDecorator])
    case failure(NetworkError)
}
