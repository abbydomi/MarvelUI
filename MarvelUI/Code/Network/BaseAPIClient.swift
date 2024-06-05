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
    
    func request(_ relativePath: String, extraQueryItems: [URLQueryItem] = []) async throws -> (Data, HTTPURLResponse) {
        
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(Environment.shared.privateKey)\(Environment.shared.apiKey)".md5()
        
        let urlString = baseURL.appendingPathComponent(relativePath)
        var components = URLComponents(url: urlString, resolvingAgainstBaseURL: true)
        let commonQueryItems = [
                    URLQueryItem(name: "ts", value: timestamp),
                    URLQueryItem(name: "hash", value: hash),
                    URLQueryItem(name: "apikey", value: Environment.shared.apiKey)
                ]
        components?.queryItems = commonQueryItems + extraQueryItems
        let (data, response) = try await URLSession.shared.data(from: components!.url!)
        
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
