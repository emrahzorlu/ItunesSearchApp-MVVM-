//
//  SearchViewModel.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 14.03.2024.
//

import Foundation

class SearchViewModel {
    private let networkingService: NetworkingService
    private var searchResults: [SearchResult] = []
    
    init(networkingService: NetworkingService = NetworkingApi()) {
        self.networkingService = networkingService
    }
    
    func search(query: String, entity: String, offset: Int, limit: Int, completion: @escaping () -> Void) {
        networkingService.searchItunesAPI(withQuery: query, entity: entity, offset: offset, limit: limit) { [weak self] results in
            self?.searchResults.append(contentsOf: results)
            completion()
        }
    }
    
    func numberOfResults() -> Int {
        return searchResults.count
    }
    
    func result(at index: Int) -> SearchResult? {
        guard index >= 0 && index < searchResults.count else {
            return nil
        }
        return searchResults[index]
    }
    
    func clearResults() {
            searchResults = []
        }
}
