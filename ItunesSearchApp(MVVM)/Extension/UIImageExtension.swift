//
//  UIImageExtension.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 11.04.2024.
//

import UIKit

extension UIImageView {
    func setImage(from urlString: String?, completion: ((Bool) -> Void)? = nil) {
        guard let urlString = urlString, let imageURL = URL(string: urlString) else {
            self.image = UIImage(named: "defaultImage")
            completion?(false)
            return
        }

        URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.image = UIImage(named: "defaultImage")
                completion?(false)
                return
            }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
                completion?(true)
            }
        }.resume()
    }
}
