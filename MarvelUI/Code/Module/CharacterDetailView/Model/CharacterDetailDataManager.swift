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
            
            guard let modified = daysSince(dateString: character.modified) else {
                throw NetworkError.badResponse
            }
            let comicURL = URL(string: character.urls.last?.url ?? "")
            
            return CharacterDetailDecorator(id: character.id,
                                            name: character.name,
                                            description: character.description,
                                            modified: modified,
                                            thumbnailURL: character.getThumbnailURL(variant: .landscapeAmazing),
                                            comicURL: comicURL)
        }
    }
    
    func getComicImagesFromCharacter(id: Int) async throws -> [CharacterDetailComicDecorator] {
        do {
            let decoder = JSONDecoder()
            let dataIn = try await decoder.decode(ComicDataIn.self, from: apiClient.getCharacterComics(id: id))
            return dataIn.data.results.map { comicDataIn in
                let comicURL = URL(string: comicDataIn.urls.first?.url ?? "")
                return CharacterDetailComicDecorator(id: comicDataIn.id,
                                                     title: comicDataIn.title,
                                                     imageURL: comicDataIn.getThumbnailURL(variant: .portraitIncredible),
                                                     comicURL: comicURL)
            }
        }
    }
    
    private func daysSince(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        guard let date = dateFormatter.date(from: dateString) else {
            print("Invalid date format")
            return nil
        }
        
        let calendar = Calendar.current
        let currentDate = Date()
        let components = calendar.dateComponents([.day], from: date, to: currentDate)
        guard let days = components.day else {
            print("Could not calculate days")
            return nil
        }
        
        return "\(days)"
    }
}
