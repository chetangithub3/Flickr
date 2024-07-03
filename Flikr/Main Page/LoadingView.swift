//
//  LoadingView.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack{
            ProgressView {
                Text("Loading")
            }
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
