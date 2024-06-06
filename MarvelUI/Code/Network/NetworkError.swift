//
//  NetworkError.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

enum NetworkError: Error {
    case badResponse
    case needsAuth
    case serviceDown
    case notFound
    case unknown
}
