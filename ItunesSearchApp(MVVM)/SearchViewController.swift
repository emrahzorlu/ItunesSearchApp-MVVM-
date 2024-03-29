//
//  SearchViewController.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 8.03.2024.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController, UISearchBarDelegate {
    private let searchBar: UISearchBar = UISearchBar()
    private let segmentedControl: UISegmentedControl = UISegmentedControl(items: ["Movies", "Music", "Ebook", "Podcast"])
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private let cellIdentifier = "Cell"
    private let viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    func configure() {
        view.backgroundColor = .systemBackground
        segmentedControl.selectedSegmentIndex = 0
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        view.addSubview(searchBar)
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)

        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        loadingIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfResults()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Cell could not be dequeued")
        }
        if let result = viewModel.result(at: indexPath.item) {
            cell.configure(with: result)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 2
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.loadMoreResults(query: searchBar.text ?? "", entity: entityForSelectedSegment(), at: indexPath) { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.collectionView.reloadData()
        }
    }
}

extension SearchViewController {

    func performSearch() {
        loadingIndicator.startAnimating()
        viewModel.search(query: searchBar.text ?? "", entity: entityForSelectedSegment()) { [weak self] in
            self?.loadingIndicator.stopAnimating()
            self?.collectionView.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.clearResults()
        collectionView.reloadData()
        performSearch()
    }

    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        viewModel.clearResults()
        collectionView.reloadData()
        performSearch()
    }

    func entityForSelectedSegment() -> String {
        switch segmentedControl.selectedSegmentIndex {
        case 0: return "movie"
        case 1: return "music"
        case 2: return "ebook"
        case 3: return "podcast"
        default: return "movie"
        }
    }
}

