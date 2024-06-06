//
//  PageControl.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 6/6/24.
//

import SwiftUI

struct PageControl: View {
    @Binding var viewModel: HomeViewModel
    @Binding var pageNumber: Int
    @Binding var showLoading: Bool
    @Binding var listDecorators: [CharacterListDecorator]?
    
    var body: some View {
        HStack {
            if pageNumber > 1 {
                Button(action: {
                    showLoading = true
                    viewModel.previousPage()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.accent)
                })
            }
            Text("\(pageNumber)")
                .foregroundStyle(.accent)
            if listDecorators?.count ?? 0 > 49 {
                Button(action: {
                    showLoading = true
                    viewModel.nextPage()
                }, label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.accent)
                })
            }
        }
        .padding()
    }
}
