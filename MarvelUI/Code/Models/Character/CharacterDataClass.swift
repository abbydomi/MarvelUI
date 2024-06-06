//
//  CharacterDataClass.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

struct CharacterDataClass: Codable {
    let offset, limit, total, count: Int
    let results: [CharacterResult]
}
