//
//  SettingsView.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 5/6/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Spacer()
            Image("spideyLogo")
                .resizable()
                .scaledToFit()
                .opacity(0.05)
                .padding()
            Spacer()
            Text("App by Abby Domínguez")
                .foregroundStyle(.accent)
                .font(.system(.subheadline, design: .rounded))
            Text("Marvel, and its characters are property of Marvel / Disney")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.gray)
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
