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
    private let cellIdentifier = "Cell"
    private let viewModel = SearchViewModel()
    private var searchThrottle: Throttle?
    private var offset = 0
    private var limit = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        searchBar.delegate = self
        segmentedControl.selectedSegmentIndex = 0
    }


    func configure(){
        view.backgroundColor = .systemBackground
        searchBar.placeholder = "Search..."
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
        view.addSubview(searchBar)
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        
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
           let lastItem = viewModel.numberOfResults() - 1
           if indexPath.item == lastItem {
               offset += limit 
               performSearch()
           }
       }
}


extension SearchViewController {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        offset = 0
        performSearch()
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl) {
        offset = 0
        performSearch()
    }
    
    
    func performSearch() {
        guard let query = searchBar.text, query.count >= 3 else {
            viewModel.clearResults()
            collectionView.reloadData()
            return
        }
        
        let selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        let entity: String
        switch selectedSegmentIndex {
        case 0:
            entity = "movie"
        case 1:
            entity = "music"
        case 2:
            entity = "ebook"
        case 3:
            entity = "podcast"
        default:
            entity = "movie"
        }
        
        searchThrottle?.cancel()
        searchThrottle = Throttle(minimumDelay: 0.5)
        searchThrottle?.throttle {
            [weak self] in
            if self?.offset == 0 {
                 self?.viewModel.clearResults()
             }
            self?.viewModel.search(query: query, entity: entity,offset: self!.offset, limit: self!.limit) { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
}
