//
//  ResultsView.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        ItemDetailView(apiService: APIService(), detailViewModel: ItemDetailViewModel(item: item))
                    } label: {
                        AsyncImage(url: URL(string: item.media?.m ?? "")!)
                            .accessibilityLabel("Image title: \(item.title ?? "")")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getScreenBounds().width / 2 - 20, height: getScreenBounds().width / 2 - 40)
                            .cornerRadius(20)
                    }
                }
            })
        }.padding(.horizontal)
    }
}

#Preview {
    ResultsView()
}
