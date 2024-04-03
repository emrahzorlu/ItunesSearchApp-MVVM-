//
//  LoadingCompatibleProtocol.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 2.04.2024.
//

import Foundation
import UIKit

protocol LoadingCompatibleProtocol: UIViewController {
    var loadingCount: Int { get set }
    var isLoadingViewVisible: Bool { get set }

    func startLoading()
    func stopLoading()
}

public func delay(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

extension LoadingCompatibleProtocol {
    var loadingViewTag: Int {
        return 125925191
    }
    
    public var isLoading: Bool {
        return loadingCount > 0
    }
    
    func startLoading() {
        loadingCount += 1
        handleLoadingViewState()
    }
    
    func stopLoading() {
        loadingCount -= 1
        handleLoadingViewState()
    }
    
    private func handleLoadingViewState(){
        #if DEBUG
        print("***** \(loadingCount) ***** \(String(describing: self))")
        #endif
        if loadingCount < 0 { loadingCount = 0 }
        if loadingCount > 0 && isLoadingViewVisible { return }
        if loadingCount == 0 && isLoadingViewVisible == false { return }
        if loadingCount > 0 {
            view.endEditing(true)
            view.viewWithTag(loadingViewTag)?.removeFromSuperview()
            // show loading view
            isLoadingViewVisible = true
            navigationController?.navigationBar.isUserInteractionEnabled = false
        } else {
            // hide loading view
            isLoadingViewVisible = false
        }
    }
}

