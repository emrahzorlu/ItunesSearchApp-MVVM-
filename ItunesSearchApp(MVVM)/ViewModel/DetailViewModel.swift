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
    func getPrimaryGenreName() -> String
    func getTrackDuration() -> String
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
            return "All Collection: \(price)$"
        } else {
            return "All Collection: Free"
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
    
    func getPrimaryGenreName() -> String {
        return searchResult?.primaryGenreName ?? ""
    }
    
    func formattedTime(milliseconds: Int) -> String {
        let totalSeconds = Int(milliseconds) / 1000
        let seconds = totalSeconds % 60
        let minutes = (totalSeconds / 60) % 60
        let hours = totalSeconds / 3600
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }

    func getTrackDuration() -> String {
        return formattedTime(milliseconds: searchResult?.trackTimeMillis ?? 0)
    }
}
