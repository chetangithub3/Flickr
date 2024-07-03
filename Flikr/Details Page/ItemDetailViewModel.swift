//
//  ItemDetailViewModel.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import Foundation
import UIKit
class ItemDetailViewModel: ObservableObject {
    @Published var item: Item
    @Published var imageWidth: Int?
    @Published var imageHeight: Int?
    @Published var description: String?
    @Published var date: String?
    @Published var showAlert = false
    @Published var alertMessage = ""
    var apiService: APIServiceProtocol
    init(item: Item, apiService: APIServiceProtocol) {
        self.item = item
        self.apiService = apiService
        parseDescription()
        parseImageSizeFromDescription()
        formattedDate()
    }
    
    func parseDescription() {
        guard let description = item.description else { return }
        let des = description.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        self.description = des
    }
    
    func parseImageSizeFromDescription() {
        guard let description = item.description else { return }
        let pattern = #"width="(\d+)"\s+height="(\d+)""#
        let regex = try! NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: description.utf16.count)
        if let match = regex.firstMatch(in: description, options: [], range: range) {
            if let widthRange = Range(match.range(at: 1), in: description),
               let heightRange = Range(match.range(at: 2), in: description) {
                let width = Int(description[widthRange]) ?? 0
                let height = Int(description[heightRange]) ?? 0
                imageWidth = width
                imageHeight = height
            }
        }
    }
    
    func formattedDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = formatter.date(from: item.published ?? "") {
            formatter.dateFormat = "MMM d, yyyy"
            self.date =  formatter.string(from: date)
        }
    }
    
    func shareItem() async {
        guard let imageUrlString = item.media?.m,
              let imageUrl = URL(string: imageUrlString) else {
            showAlert = true
            return
        }
        let request = URLRequest(url: imageUrl)
        let result = await apiService.fetch(request: request)
        switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    showAlert = true
                    return
                }
                let activityItems: [Any] = [image, item.title ?? "Image"]
                await MainActor.run {
                    let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
                    UIApplication.shared.keyWindow?.rootViewController?
                        .present(activityViewController, animated: true, completion: nil)
                }
                break
            case .failure(_):
                showAlert = true
        }
    }
}



