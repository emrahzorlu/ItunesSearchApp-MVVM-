//
//  SearchModel.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 8.03.2024.
//

import Foundation

struct SearchResult: Decodable {
    let artworkUrl100: String?
    let collectionPrice: Double?
    let collectionName: String?
    let releaseDate: String?
    let artistName: String?
    let trackName: String?
    let trackPrice: Double?
    let primaryGenreName: String?
    let trackTimeMillis: Int? 
}
