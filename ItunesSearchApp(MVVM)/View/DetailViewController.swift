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

class DetailViewController: UIViewController {
    var viewModel: DetailBusinessLayer

    init(viewModel: DetailBusinessLayer) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let artWorkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
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
    
    private let collectionNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let trackPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let collectionPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blue
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configure(with: viewModel)
    }
    
    func configureUI(){
        view.backgroundColor = .white
        view.addSubview(artWorkImageView)
        view.addSubview(trackNameLabel)
        view.addSubview(artistNameLabel)
        view.addSubview(collectionNameLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(collectionPriceLabel)
        view.addSubview(trackPriceLabel)
                
        artWorkImageView.layer.shadowColor = UIColor.black.cgColor
        artWorkImageView.layer.shadowOpacity = 1.0
        artWorkImageView.layer.shadowOffset = CGSize(width: 0, height: 8)
        artWorkImageView.layer.shadowRadius = 12
        
        artWorkImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(90)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(artWorkImageView.snp.width).multipliedBy(0.8)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalTo(artWorkImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        collectionNameLabel.snp.makeConstraints { make in
            make.top.equalTo(artistNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        trackPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
        
        collectionPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(trackPriceLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    func configure(with viewModel: DetailBusinessLayer) {
        trackNameLabel.text = viewModel.getTrackName()
        artistNameLabel.text = viewModel.getArtistName()
        collectionNameLabel.text = viewModel.getCollectionName()
        releaseDateLabel.text = viewModel.getReleaseDate()
        trackPriceLabel.text = viewModel.getTrackPrice()
        collectionPriceLabel.text = viewModel.getCollectionPrice()
        artWorkImageView.setImage(from: viewModel.getUrl())
    }
}
