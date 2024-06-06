//
//  Toolbar.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import SwiftUI

struct ToolbarView: View {
    @EnvironmentObject var router: Router
    @State var showBackButton = false
    
    var body: some View {
        Color.clear
            .frame(width: 0, height: 0)
        .navigationTitle("")
        .toolbar(content: {
            ZStack {
                HStack {
                    Image("MarvelLogo")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            router.popToRoot()
                        }
                }
                HStack {
                    if showBackButton {
                        Button(action: {
                            router.goBack()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .imageScale(.large)
                                .foregroundStyle(.white)
                        })
                    }
                    Spacer()
                    Button(action: {
                        router.navigateTo(.settings)
                    }, label: {
                        Image(systemName: "gear")
                            .imageScale(.large)
                            .foregroundStyle(.white)
                    })
                }
            }
        })
        .toolbarBackground(Color.accentColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}
