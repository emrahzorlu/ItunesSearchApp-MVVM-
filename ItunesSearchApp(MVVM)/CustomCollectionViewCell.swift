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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        
        
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
    }
    
    func updateImage(with imageURL: URL?) {
        
        guard let imageURL = imageURL else { return }
        
           
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: imageURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    UIView.transition(with: self.imageView,duration: 0.5,options: .transitionFlipFromTop, animations: {
                        self.imageView.image = image
                       },completion: nil)
                   }
               }
           }
       }

    func configure(with result: SearchResult) {
           titleLabel.text = result.trackName ?? ""
           
           guard let urlString = result.artworkUrl100, let url = URL(string: urlString) else {
               imageView.image = UIImage(named: "defaultImage")
               return
           }
           
           updateImage(with: url)
       }
   }


