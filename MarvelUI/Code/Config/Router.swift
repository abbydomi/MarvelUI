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
        case characterDetail
    }
    
    @Published var path = NavigationPath()
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func goBack() {
        path.removeLast()
    }
    
    func nextView(_ destination: Destination) {
        path.append(destination)
    }
}