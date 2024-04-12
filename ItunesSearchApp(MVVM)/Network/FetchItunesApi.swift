//
//  ItunesApi.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 8.03.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

protocol NetworkingService {
    func searchItunesAPI(withQuery query: String, entity: String, offset: Int, limit: Int, completion: @escaping (Result<[SearchResult], NetworkError>) -> ())
}

final class NetworkingApi: NetworkingService {
    private let session = URLSession.shared
    
    func searchItunesAPI(withQuery query: String, entity: String, offset: Int, limit: Int, completion: @escaping (Result<[SearchResult], NetworkError>) -> ()) {
        let editedQuery = query.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://itunes.apple.com/search?term=\(editedQuery)&media=\(entity)&sort=popularity&offset=\(offset)&limit=\(limit)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { (data, _, _) in //URLResponse
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }
        task.resume()
    }
}

fileprivate struct SearchResponse: Decodable {
    let results: [SearchResult]
}
