//
//  HomeViewModel.swift
//  Flikr
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import Foundation
@MainActor
class HomeViewModel: ObservableObject {
    private var currentTask: Task<Void, Never>? = nil
    private var listenerTask: Task<Void, Never>? = nil
    var apiService: APIServiceProtocol
    @Published var searchText = ""
    @Published var loadingState: LoadingState = .none
    @Published var items: [Item] = [Item]()
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        self.searchFieldListener()
    }
    
    func searchFieldListener() {
         listenerTask = Task {
             var lastSearchText = ""
             while true {
                 if searchText.isEmpty {
                     loadingState = .none
                 }
                 try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds, similar to debounce
                 let currentSearchText = self.searchText
                 if currentSearchText != lastSearchText {
                     lastSearchText = currentSearchText
                     if !currentSearchText.isEmpty {
                         self.currentTask?.cancel()
                         self.currentTask = Task {
                             await self.callAPI(text: currentSearchText)
                         }
                     }
                 }
             }
         }
     }
    
    func callAPI(text: String) async {
        let url = Constants.API.baseURL + text
        guard let URL = URL(string: url) else {
            loadingState = .failure(NetworkError.badRequest)
            return
        }
        await fetch(from: URL)
    }
    
    func fetch(from url: URL) async {
        self.loadingState = .loading
        let request = URLRequest(url: url)
        let result = await apiService.fetch(request: request)
        switch result {
            case .success(let data):
                decodeData(data: data)
                break
            case .failure(let error):
                self.loadingState = .failure(error)
                break
        }
    }
    
    func decodeData(data: Data) {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let flickrData = try decoder.decode(Res.self, from: data)
            if let items = flickrData.items {
                self.items = items
                self.loadingState = .success
            }
        } catch {
            self.loadingState = .failure(error)
        }
    }
}
