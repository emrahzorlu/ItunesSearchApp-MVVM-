//
//  MockNetworkingApi.swift
//  ItunesSearchApp(MVVM)Tests
//
//  Created by Emrah Zorlu on 16.05.2024.
//

import Foundation
@testable import ItunesSearchApp_MVVM_

enum MockError: Error {
    case networkError
}

class MockNetworkingApi: NetworkingService {
    var mockResult: Result<[SearchResult],NetworkError> = .failure(.fake)
    private(set) var invocations: [Invocation] = []
    
    enum Invocation:Equatable {
        case searchItunesAPI(query: String, mediaType: String)
    }
    
    func searchItunesAPI(withQuery query: String, mediaType: String, offset: Int, limit: Int, completion: @escaping (Result<[SearchResult], NetworkError>) -> ()) {
        invocations.append(.searchItunesAPI(query: query, mediaType: mediaType))
        completion(mockResult)
    }
}
