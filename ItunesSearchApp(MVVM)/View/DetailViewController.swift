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
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()

    
    private let trackDurationLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor = .gray
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    private let colletionPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("₺0,99", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configure(with: viewModel)
        updateColorsForDarkMode()
    }

    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(artWorkImageView)
        view.addSubview(trackNameLabel)
        view.addSubview(trackDurationLabel)
        view.addSubview(artistNameLabel)
        view.addSubview(genreLabel)
        view.addSubview(releaseDateLabel)
        view.addSubview(buyButton)
        view.addSubview(colletionPriceLabel)
        
        artWorkImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(artWorkImageView.snp.width)
        }
        
        trackNameLabel.snp.makeConstraints { make in
            make.top.equalTo(artWorkImageView.snp.bottom).offset(40)
            make.leading.equalToSuperview().inset(20)
        }
        
        trackDurationLabel.snp.makeConstraints { make in
            make.leading.equalTo(trackNameLabel.snp.trailing).offset(8)
            make.bottom.equalTo(trackNameLabel)
            make.trailing.lessThanOrEqualToSuperview().inset(20)
        }
        
        artistNameLabel.snp.makeConstraints { make in
            make.top.equalTo(trackNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(trackNameLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(artistNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(trackNameLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.leading.equalTo(trackNameLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        buyButton.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        
        colletionPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(buyButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }



    func configure(with viewModel: DetailBusinessLayer) {
        trackNameLabel.text = viewModel.getTrackName()
        artistNameLabel.text = viewModel.getArtistName()
        genreLabel.text = viewModel.getPrimaryGenreName()
        releaseDateLabel.text = viewModel.getReleaseDate()
        colletionPriceLabel.text = viewModel.getCollectionPrice()
        trackDurationLabel.text = viewModel.getTrackDuration()
        buyButton.setTitle(viewModel.getTrackPrice(), for: .normal)
        artWorkImageView.setImage(from: viewModel.getUrl())
    }
}

extension DetailViewController {
    func updateColorsForDarkMode() {
        if traitCollection.userInterfaceStyle == .dark {

            view.backgroundColor = .black
            trackNameLabel.textColor = .white
            trackDurationLabel.textColor = .lightGray
            artistNameLabel.textColor = .lightGray
            genreLabel.textColor = .lightGray
            releaseDateLabel.textColor = .lightGray
            colletionPriceLabel.textColor = .systemBlue
            buyButton.backgroundColor = .systemBlue
        } else {

            view.backgroundColor = .systemBackground
            trackNameLabel.textColor = .black
            trackDurationLabel.textColor = .gray
            artistNameLabel.textColor = .gray
            genreLabel.textColor = .gray
            releaseDateLabel.textColor = .gray
            colletionPriceLabel.textColor = .systemBlue
            buyButton.backgroundColor = .systemBlue
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateColorsForDarkMode()
    }
}
