//
//  CharacterListDecorator.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

struct CharacterListDecorator: Identifiable {
    let id: Int
    let name, description: String
    let thumbnailURL: URL?
}
