//
//  Environment.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

final class Environment {
    
    // MARK: - Constants
    
    let apiKey: String = "da20868a0917569fe4925d52ec65b783"
    let privateKey: String = "6510d1c67cb264301d2c65270146ce3c203a7f9b"
    let baseURL: String = "https://gateway.marvel.com/v1/public/"
    
    // MARK: - Shared Instance
    
    static let shared = Environment()
}
