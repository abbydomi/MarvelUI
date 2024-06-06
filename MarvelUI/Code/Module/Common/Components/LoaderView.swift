//
//  Loader.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 6/6/24.
//

import SwiftUI

struct LoaderView: View {
    @State var backgroundColor: Color = Color.white
    @State var spinnerColor: Color = Color.accentColor
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: spinnerColor))
        }
    }
}

#Preview {
    LoaderView()
}
