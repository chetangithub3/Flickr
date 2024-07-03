//
//  HomeView.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 0){
                SearchableTextFieldView()
                Spacer()
                switch viewModel.loadingState {
                    case .none:
                        EmptySearchBarResultsView()
                    case .loading:
                        ProgressView()
                    case .success:
                        if viewModel.items.isEmpty {
                           NoResultsView()
                        } else {
                            ResultsView()
                        }
                    case .failure(let error):
                        ErrorView(error: error)
                }
            }.background(Color.yellow.opacity(0.3))
                .environment(\.sizeCategory, .large)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Flikr")
        }
    }
}


