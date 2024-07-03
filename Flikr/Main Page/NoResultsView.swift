//
//  NoResultsView.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import SwiftUI

struct NoResultsView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("No Images found. Try searching something else")
            Spacer()
        }
    }
}

#Preview {
    NoResultsView()
}
