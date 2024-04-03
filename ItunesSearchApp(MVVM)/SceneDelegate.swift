//
//  SceneDelegate.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 8.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewModel = SearchViewModel()
        let searchViewController = SearchViewController(viewModel: viewModel)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = searchViewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

