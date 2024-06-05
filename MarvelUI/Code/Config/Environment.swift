//
//  Environment.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

final class Environment {
    
    // MARK: - Constants
    
    let baseURL: String = "http(s)://gateway.marvel.com//"
    
    // MARK: - Shared Instance
    
    static let shared = Environment()
}
