//
//  Stories.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}
