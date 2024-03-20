//
//  ItunesApi.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 8.03.2024.
//

import Foundation


protocol NetworkingService {
    @discardableResult func searchItunesAPI(withQuery query: String, entity: String, offset: Int, limit: Int, completion: @escaping ([SearchResult]) -> ()) -> URLSessionDataTask
}

final class NetworkingApi: NetworkingService {
    private let session = URLSession.shared
    
    @discardableResult
    func searchItunesAPI(withQuery query: String, entity: String, offset: Int, limit: Int, completion: @escaping ([SearchResult]) -> ()) -> URLSessionDataTask {
        
        let editedQuery = query.replacingOccurrences(of: " ", with: "+")
        let urlString = "https://itunes.apple.com/search?term=\(editedQuery)&media=\(entity)&sort=popularity&offset=\(offset)&limit=\(limit)"
        print(urlString)
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL")
        }
        
        let task = session.dataTask(with: url) { (data, _, _) in //URLResponse
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
                    completion([])
                    return
                }
                completion(response.results)
            }
        }
        task.resume()
        return task
    }
}


fileprivate struct SearchResponse: Decodable {
    let results: [SearchResult]
}
