//
//  ButtonGoBackPrimary.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 6/6/24.
//

import SwiftUI

struct ButtonGoBackPrimary: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        Button {
            router.goBack()
        } label: {
            Text("Go back")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(.capsule)
                .padding(.horizontal)
        }
    }
}

#Preview {
    ButtonGoBackPrimary()
}
