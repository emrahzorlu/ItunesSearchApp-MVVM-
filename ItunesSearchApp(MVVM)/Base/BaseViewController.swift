//
//  BaseViewController.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 5.04.2024.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    var loadingIndicator: UIActivityIndicatorView
    
    init() {
        self.loadingIndicator = UIActivityIndicatorView(style: .medium)
        self.loadingIndicator.hidesWhenStopped = true
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
