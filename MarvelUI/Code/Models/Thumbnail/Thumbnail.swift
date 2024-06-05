//
//  Thumbnail.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
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
