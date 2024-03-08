//
//  SearchViewModel.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 8.03.2024.
//

import Foundation

class SearchViewModel {
    private let networkingService: NetworkingService
    
    var searchResults: [SearchResult] = []
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    func search(query: String, entity: String, completion: @escaping () -> Void) {
        networkingService.searchItunesAPI(withQuery: query, entity: entity) { [weak self] results in
            self?.searchResults = results
            completion()
        }
    }
}
