//
//  FlikrApp.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import SwiftUI

@main
struct FlikrApp: App {
    @StateObject var viewModel = HomeViewModel(apiService: APIService())
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
                .preferredColorScheme(.light)
        }
    }
}
