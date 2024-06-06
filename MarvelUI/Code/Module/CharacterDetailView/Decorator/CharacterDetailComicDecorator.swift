//
//  CharacterDetailComicDecorator.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 6/6/24.
//

import UIKit

struct CharacterDetailComicDecorator: Codable, Identifiable {
    let id: Int
    let title: String
    let imageURL: URL?
    let comicURL: URL?
}
