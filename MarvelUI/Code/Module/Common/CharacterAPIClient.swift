//
//  CharacterAPIClient.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

class CharacterAPIClient: BaseAPIClient {
    
    func getCharacters(limit: Int, offset: Int, name: String, orderBy: OrderSelection) async throws -> Data {
        let path = "characters"
        var orderByParsed = "name"
        switch orderBy {
        case .nameAscending:
            orderByParsed = "name"
        case .nameDescending:
            orderByParsed = "-name"
        case .modifiedAscending:
            orderByParsed = "modified"
        case .modifiedDescending:
            orderByParsed = "-modified"
        }
        var queryItems: [URLQueryItem] = []
        if !name.isEmpty {
            queryItems = [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "offset", value: String(offset)),
                URLQueryItem(name: "nameStartsWith", value: name),
                URLQueryItem(name: "orderBy", value: orderByParsed)
            ]
        } else {
            queryItems = [
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "offset", value: String(offset)),
                URLQueryItem(name: "orderBy", value: orderByParsed)
            ]
        }
        return try await request(path, extraQueryItems: queryItems).0
    }
    
    func getCharacter(id: Int) async throws -> Data {
        let path = "characters/\(id)"
        return try await request(path).0
    }
    
    func getCharacterComics(id: Int) async throws -> Data {
        let path = "characters/\(id)/comics"
        return try await request(path).0
    }
}
