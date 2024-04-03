//
//  BaseControllerProtocol.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 2.04.2024.
//

import Foundation

protocol BaseControllerProtocol: AnyObject { }

protocol BaseViewModelProtocol: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func viewWillAppear()
    func viewDidDisappear()
    func viewWillDisappear()
    func didEnterBackground()
}

extension BaseViewModelProtocol {
    func viewDidLoad() { }
    func viewDidAppear() { }
    func viewWillAppear() { }
    func viewDidDisappear() { }
    func viewWillDisappear() { }
    func didEnterBackground() { }
}
