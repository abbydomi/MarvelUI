//
//  Router.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    public enum Destination: Codable, Hashable {
        case settings
        case characterDetail(characterId: Int)
        case webView(url: URL)
    }
    
    @Published var path = NavigationPath()
    @Published var errorMessage = ""
    @Published var showError = false
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func navigateTo(_ destination: Destination) {
        path.append(destination)
    }
    
    func handleError(_ error: NetworkError) {
        switch error {
        case .badResponse:
            errorMessage = "The server response was invalid"
        case .needsAuth:
            errorMessage = "Authorization is needed to access the server"
        case .serviceDown:
            errorMessage = "The service is down"
        case .notFound:
            errorMessage = "The server did not find the data"
        case .unknown:
            errorMessage = "An unknown error has ocurred"
        }
        showError = true
    }
}
