//
//  DetailViewModel.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 5.04.2024.
//

import Foundation

protocol DetailBusinessLayer: BaseViewModelProtocol {
    var view: DetailDisplayLayer? { get set }
    var searchResult: SearchResult? { get }
    
    init(searchResult: SearchResult)
    func getTrackName() -> String
    func getArtistName() -> String
    func getImageURL() -> URL?
}

final class DetailViewModel: DetailBusinessLayer {
    weak var view: DetailDisplayLayer?
    var searchResult: SearchResult?
    
    required init(searchResult: SearchResult) {
        self.searchResult = searchResult
    }
    
    func getTrackName() -> String {
        return searchResult?.trackName ?? ""
    }
    
    func getArtistName() -> String {
        return searchResult?.artistName ?? ""
    }
    
    func getImageURL() -> URL? {
        return URL(string: searchResult?.artworkUrl100 ?? "")
    }
}
