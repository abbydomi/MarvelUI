//
//  BaseAPIClient.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation

class BaseAPIClient {
    
    private var baseURL: URL {
        if let url = URL(string: Environment.shared.baseURL) {
            return url
        } else {
            print("Invalid URL")
            return URL(string: "")!
        }
    }
    
    func request(_ relativePath: String?) async throws -> (Data, HTTPURLResponse) {
        let urlAbsolute = baseURL.appendingPathComponent(relativePath!)
        let (data, response) = try await URLSession.shared.data(from: urlAbsolute)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        
        if response.statusCode == 200 {
            return (data, response)
        }
        
        switch response.statusCode {
        case 401:
            throw NetworkError.needsAuth
        case 522:
            throw NetworkError.serviceDown
        case 404:
            throw NetworkError.notFound
        default:
            throw NetworkError.unknown
        }
    }
}
