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

enum CharacterDetailState {
    case loading
    case success(CharacterDetailDecorator)
}
