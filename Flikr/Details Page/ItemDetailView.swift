//
//  ItemDetailView.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import Foundation
import SwiftUI

struct ItemDetailView: View {
    var apiService: APIServiceProtocol
    @ObservedObject var detailViewModel: ItemDetailViewModel
    
    init(apiService: APIServiceProtocol, detailViewModel: ItemDetailViewModel) {
        self.apiService = apiService
        self.detailViewModel = detailViewModel
    }
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    if let imageUrlString = detailViewModel.item.media?.m {
                        VStack(alignment: .center){
                            AsyncImage(url: URL(string: imageUrlString)!)
                                .cornerRadius(10)
                                .accessibilityLabel("Image title: \(detailViewModel.item.title ?? "")")
                        }
                    }
                }
                HStack {
                    Text(detailViewModel.item.title ?? "")
                        .bold()
                        .padding(.vertical)
                    Spacer()
                    Button(action: {
                        shareItem()
                    }) {
                        Text("Share")
                            .font(.subheadline)
                            .padding(8)
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                Text(detailViewModel.description ?? "")
                    .font(.system(size: UIFont.textStyleSize(.subheadline), weight: .light))
                Divider()
                Text("Author: \(detailViewModel.item.author ?? "")")
                    .font(.system(size: UIFont.textStyleSize(.subheadline), weight: .light))
                if let publishedDate = detailViewModel.date {
                    Text("Published Date: \(publishedDate)")
                        .font(.system(size: UIFont.textStyleSize(.subheadline), weight: .light))
                    Divider()
                    Text("Image Size: \(detailViewModel.imageWidth ?? 0) x \(detailViewModel.imageHeight ?? 0)")
                        .font(.system(size: UIFont.textStyleSize(.subheadline), weight: .light))
                }
                Spacer()
            }.padding()
            .environment(\.sizeCategory, .large)
            .navigationTitle("Detail View")
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(Color.yellow.opacity(0.3))
        
        
    }
    
    func shareItem() {
        guard let imageUrlString = detailViewModel.item.media?.m,
              let imageUrl = URL(string: imageUrlString) else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            guard let data = data,
                  let image = UIImage(data: data) else { return }
            
            let activityItems: [Any] = [image, detailViewModel.item.title ?? ""]
            
            DispatchQueue.main.async {
                let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
                UIApplication.shared.keyWindow?.rootViewController?
                    .present(activityViewController, animated: true, completion: nil)
            }
        }.resume()
    }
}
