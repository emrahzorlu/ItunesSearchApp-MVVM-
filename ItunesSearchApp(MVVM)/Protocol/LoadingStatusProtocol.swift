//
//  LoadingCompatibleProtocol.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 5.04.2024.
//

import Foundation
import UIKit

protocol LoadingStatusProtocol: UIViewController {
    var loadingIndicator: UIActivityIndicatorView { get }

    func startAnimating()
    func stopAnimating()
}
extension LoadingStatusProtocol {
    func startAnimating() {
        loadingIndicator.startAnimating()
    }
    
    func stopAnimating() {
        loadingIndicator.stopAnimating()
    }
}
