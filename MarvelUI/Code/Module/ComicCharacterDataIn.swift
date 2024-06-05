//
//  ComicCharacterDataIN.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

// MARK: - CharacterDataIn
struct CharacterDataIn: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
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

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: String
}

enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
    case ad = "ad"
    case backcovers = "backcovers"
    case pinup = "pinup"
    case textArticle = "text article"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}

enum ImageVariants: String {
    case portraitSmall = "portrait_small"
    case portraitMedium = "portrait_medium"
    case portraitLarge = "portrait_xlarge"
    case portraitFantastic = "portrait_fantastic"
    case portraitUncanny = "portrait_uncanny"
    case portraitIncredible = "portrait_incredible"
    
    case squareSmall = "standard_small"
    case squareMedium = "standard_medium"
    case squareLarge = "standard_large"
    case squareExtraLarge = "standard_xlarge"
    case squareFantastic = "standard_fantastic"
    case squareAmazing = "standard_amazing"
    
    case landscapeSmall = "landscape_small"
    case landscapeLarge = "landscapeLarge"
    case landscapeExtraLarge = "landscape_xlarge"
    case landscapeAmazing = "landscape_amazing"
    case landscapeIncredible = "landscape_incredible"
}
