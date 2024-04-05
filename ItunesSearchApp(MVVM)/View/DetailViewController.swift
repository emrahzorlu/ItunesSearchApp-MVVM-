//
//  DetailViewController.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 5.04.2024.
//

import UIKit
import SnapKit

protocol DetailDisplayLayer: BaseControllerProtocol {
    func configureUI()
    func configure()
}

class DetailViewController: BaseViewController {
    var viewModel: DetailBusinessLayer

    init(viewModel: DetailBusinessLayer) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let artworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configure(with: viewModel)
    }
    
    func configureUI(){
        view.backgroundColor = .green
        view.addSubview(artworkImageView)
        view.addSubview(trackNameLabel)
        view.addSubview(artistNameLabel)
        
        artworkImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.7)
            make.width.height.equalToSuperview().multipliedBy(0.5)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(artworkImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(trackNameLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configure(with viewModel: DetailBusinessLayer) {
        trackNameLabel.text = viewModel.getTrackName()
        artistNameLabel.text = viewModel.getArtistName()
        setImage(fromURL: viewModel.getImageURL())
    }

    
    func setImage(fromURL url: URL?) {
        if let imageURL = url {
            URLSession.shared.dataTask(with: imageURL) { [weak self] (data, _, error) in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self?.artworkImageView.image = UIImage(data: data)
                }
            }.resume()
        } else {
            artworkImageView.image = UIImage(named: "defaultImage")
        }
    }
}
