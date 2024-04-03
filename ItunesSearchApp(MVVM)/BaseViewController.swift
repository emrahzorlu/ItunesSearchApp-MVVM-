//
//  BaseViewController.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 3.04.2024.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    var loadingCount: Int = 0
    
    var isLoadingViewVisible: Bool
    
    init() {
        isLoadingViewVisible = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        debugPrint("deinit view controller : \(self)")
    }
    
    override func viewDidLoad() {
        debugPrint("viewDidLoad : \(self)")
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
