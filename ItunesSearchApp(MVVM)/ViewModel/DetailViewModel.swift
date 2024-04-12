//
//  DetailViewModel.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 5.04.2024.
//

import Foundation

import Foundation
import UIKit

protocol DetailBusinessLayer: BaseViewModelProtocol {
    var view: DetailDisplayLayer? { get set }
    var searchResult: SearchResult? { get }
    
    init(searchResult: SearchResult)
    func getTrackName() -> String
    func getArtistName() -> String
    func getCollectionName() -> String
    func getReleaseDate() -> String
    func getCollectionPrice() -> String
    func getTrackPrice() -> String
    func getUrl() -> String
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
    
    func getCollectionName() -> String {
        return searchResult?.collectionName ?? ""
    }
    
    func getReleaseDate() -> String {
        guard let releaseDateString = searchResult?.releaseDate else {
            return ""
        }
        
        let dateFormatter = ISO8601DateFormatter()
        guard let releaseDate = dateFormatter.date(from: releaseDateString) else {
            return ""
        }
        
        let humanReadableDateFormatter = DateFormatter()
        humanReadableDateFormatter.dateStyle = .long
        humanReadableDateFormatter.timeStyle = .none
        return humanReadableDateFormatter.string(from: releaseDate)
    }
    
    func getCollectionPrice() -> String {
        if let price = searchResult?.collectionPrice {
            return "\(price)$"
        } else {
            return "Free"
        }
    }
    
    func getTrackPrice() -> String {
        if let price = searchResult?.trackPrice {
            return "\(price)$"
        } else {
            return "Free"
        }
    }
    
    func getUrl() -> String {
        return searchResult?.artworkUrl100 ?? ""
    }
}
