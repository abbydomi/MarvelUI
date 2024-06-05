//
//  HomeDataManager.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

class HomeDataManager {
    
    private let characterAPIClient = CharacterAPIClient()
    
    func getCharacters(limit: Int, offset: Int, name: String, orderBy: OrderSelection) async throws -> [CharacterListDecorator] {
        do {
            let decoder = JSONDecoder()
            let dataIn = try await decoder.decode(CharacterDataIn.self, from: characterAPIClient.getCharacters(limit: limit, offset: offset, name: name, orderBy: orderBy))
            return dataIn.data.results.map { comicCharacter in
                return CharacterListDecorator(id: comicCharacter.id,
                                              name: comicCharacter.name,
                                              description: comicCharacter.description,
                                              thumbnailURL: comicCharacter.getThumbnailURL(variant: .squareMedium))
            }
        }
    }
}
