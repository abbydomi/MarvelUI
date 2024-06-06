//
//  CharacterDetailDataManager.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

class CharacterDetailDataManager {
    
    private var apiClient = CharacterAPIClient()
    
    func getCharacter(id: Int) async throws -> CharacterDetailDecorator {
        do {
            let decoder = JSONDecoder()
            let dataIn = try await decoder.decode(CharacterDataIn.self,
                                                from: apiClient.getCharacter(id: id))
            guard let character = dataIn.data.results.first else {
                throw NetworkError.badResponse
            }
            return CharacterDetailDecorator(id: character.id,
                                            name: character.name,
                                            description: character.description,
                                            modified: character.modified,
                                            thumbnailURL: character.getThumbnailURL(variant: .landscapeAmazing))
        }
    }
}
