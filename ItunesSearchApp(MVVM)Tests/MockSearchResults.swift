//
//  MockSearchResults.swift
//  ItunesSearchApp(MVVM)Tests
//
//  Created by Emrah Zorlu on 16.05.2024.
//

import Foundation
@testable import ItunesSearchApp_MVVM_

extension SearchResult {
    static func fake (
        artworkUrl100: String? = "",
        collectionPrice: Double? = 0.0,
        collectionName: String? = "",
        releaseDate: String? = "",
        artistName: String? = "",
        trackName: String? = "",
        trackPrice: Double? = 0.0
    ) -> SearchResult {
        return SearchResult(artworkUrl100: artworkUrl100,
            collectionPrice: collectionPrice,
            collectionName: collectionName,
            releaseDate: releaseDate,
            artistName: artistName,
            trackName: trackName,
            trackPrice: trackPrice
        )
    }
}
