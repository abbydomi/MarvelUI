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
                    .environmentObject(router)
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .settings: SettingsView()
                        default: Color.clear
                        }
                    }
            }
        }
    }
}
