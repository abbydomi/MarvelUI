//
//  Comic.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 6/6/24.
//

import Foundation

struct ComicResult: Codable, Identifiable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail
    let urls: [URLElement]
    
    func getThumbnailURL(variant: ImageVariants) -> URL? {
        return URL(string: "\(thumbnail.path)/\(variant.rawValue).\(thumbnail.thumbnailExtension)")
    }
}
