//
//  MarvelUIApp.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import SwiftUI

@main
struct MarvelUIApp: App {
    
    @StateObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                HomeView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .settings: 
                            SettingsView()
                        case .characterDetail(let characterId):
                            let viewModel = CharacterDetailViewModel(characterID: characterId)
                            CharacterDetailView(viewModel: viewModel)
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
