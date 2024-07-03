//
//  SearchableTextFieldView.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import SwiftUI

struct SearchableTextFieldView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        HStack{
            TextField("Seach images", text: $viewModel.searchText)
                .padding(10)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(viewModel.searchText.isEmpty ? Color.gray : Color.blue, lineWidth: 1)
                )
                .padding()
                .accessibilityLabel("Search for images")
        }
        .overlay {
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView().padding(.horizontal).padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    SearchableTextFieldView()
}
