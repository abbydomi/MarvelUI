//
//  CharacterAPIClient.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

class CharacterAPIClient: BaseAPIClient {
    
    func getCharacters(limit: Int, offset: Int) async throws -> Data {
        let path = "characters"
        let queryItems = [
                    URLQueryItem(name: "limit", value: String(limit)),
                    URLQueryItem(name: "offset", value: String(offset))
                ]
        return try await request(path, extraQueryItems: queryItems).0
    }
}
