//
//  UIImageExtension.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 11.04.2024.
//

import UIKit

enum ImageLoadError: Error {
    case invalidURL
    case failedToLoadData
}

extension UIImageView {
    func setImage(from urlString: String?, completion: ((Result<Bool, ImageLoadError>) -> Void)? = nil) {
        guard let urlString = urlString, let imageURL = URL(string: urlString) else {
            DispatchQueue.main.async{
                self.image = UIImage(named: "defaultImage")
            }
            completion?(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: imageURL) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async{
                    self?.image = UIImage(named: "defaultImage")
                }
                completion?(.failure(.failedToLoadData))
                return
            }
            DispatchQueue.main.async {
                self?.image = UIImage(data: data)
                completion?(.success(true))
            }
        }.resume()
    }
}
