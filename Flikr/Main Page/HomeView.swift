//
//  HomeView.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0){
                SearchableTextFieldView()
                Spacer()
                if !viewModel.items.isEmpty {
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
            }.background(Color.yellow.opacity(0.3))
                .environment(\.sizeCategory, .large)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Flikr")
        }
    }
}
