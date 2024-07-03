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
                    if let urlString = item.media?.m {
                        NavigationLink {
                            ItemDetailView(apiService: APIService(), detailViewModel: ItemDetailViewModel(item: item, apiService: APIService()))
                        } label: {
                            VStack {
                                AsyncImage(url: URL(string:  urlString)!) { image in
                                    image
                                } placeholder: {
                                    ProgressView()
                                }
                            }.accessibilityLabel("Image title: \(item.title ?? "")")
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getScreenBounds().width / 2 - 20, height: getScreenBounds().width / 2 - 40)
                                .cornerRadius(20)
                        }
                    }
                }
            })
        }.padding(.horizontal)
    }
}

#Preview {
    ResultsView()
}
