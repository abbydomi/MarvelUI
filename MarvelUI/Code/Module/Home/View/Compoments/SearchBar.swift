//
//  SearchBar.swift
//  MarvelUI
//
//  Created by Abby Dominguez on 6/6/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var viewModel: HomeViewModel
    @Binding var orderSelection: OrderSelection
    @Binding var searchText: String
    var body: some View {
        VStack {
            HStack {
                TextField("Search...", text: $searchText)
                    .placeholder(when: searchText.isEmpty, placeholder: {
                        Text("Search...")
                            .foregroundStyle(.accent)
                    })
                    .onSubmit {
                        viewModel.searchCharacter(name: searchText, orderBy: orderSelection)
                    }
                    .foregroundStyle(.accent)
                    .padding()
                Picker("Order by", selection: $orderSelection) {
                    ForEach(OrderSelection.allCases) { order in
                        Text(order.rawValue)
                            .tag(order)
                            .font(.system(size: 100, weight: .bold, design: .rounded))
                    }
                }
                Button(action: {
                    viewModel.searchCharacter(name: searchText, orderBy: orderSelection)
                }, label: {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 30)
                        .foregroundStyle(.accent)
                        .padding(.trailing)
                })
            }
            Rectangle()
                .fill(Color.gray)
                .frame(maxWidth: .infinity, maxHeight: 1)
        }
    }
}
