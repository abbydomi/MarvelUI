//
//  CharacterResult.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

struct CharacterResult: Codable {
    let id: Int
    let name, description: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics, series: Comics
    let stories: Stories
    let events: Comics
    let urls: [URLElement]
    
    func getThumbnailURL(variant: ImageVariants) -> URL? {
        return URL(string: "\(thumbnail.path)/\(variant.rawValue).\(thumbnail.thumbnailExtension)")
    }
}

struct URLElement: Codable {
    let type: String
    let url: String
}