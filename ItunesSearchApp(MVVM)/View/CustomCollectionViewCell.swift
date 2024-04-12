//
//  CustomCollectionViewCell.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 8.03.2024.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        
        activityIndicator.hidesWhenStopped = true
        contentView.addSubview(activityIndicator)
        
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.height).multipliedBy(0.8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func configure(with result: SearchResult, delegate: SearchViewController) {
        titleLabel.text = result.trackName
        imageView.image = nil
        activityIndicator.startAnimating()
                
        imageView.setImage(from: result.artworkUrl100) { [weak self] result in
            switch result {
            case .success:
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                self?.activityIndicator.stopAnimating()
                let errorMessage: String
                switch error {
                case .invalidURL:
                    errorMessage = "Invalid URL."
                case .failedToLoadData:
                    errorMessage = "Failed to load data."
                }
                let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                delegate.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
