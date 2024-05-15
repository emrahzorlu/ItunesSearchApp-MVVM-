//
//  SearchViewModel.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 14.03.2024.
//

// SearchViewModel.swift

import Foundation

protocol MainBusinessLayer: BaseViewModelProtocol {
    var view: MainDisplayLayer? { get set }
    func numberOfResults() -> Int
    func result(at index: Int) -> SearchResult?
    func search(query: String, entity: String, completion: @escaping () -> Void)
    func loadMoreResults(query: String, entity: String, at indexPath: IndexPath, completion: @escaping () -> Void)
    func clearResults()
    }

final class SearchViewModel: MainBusinessLayer {

    weak var view: MainDisplayLayer?
    private let networkingService: NetworkingService
    private var searchResults: [SearchResult] = []
    private var offset = 0
    private var limit = 20
    private var searchThrottle: Throttle?
    private var dataSource: DataSource
    
    init(networkingService: NetworkingService = NetworkingApi(), dataSource: DataSource = DataSource()) {
        self.networkingService = networkingService
        self.dataSource = dataSource
    }
    
    func viewDidLoad() {
        view?.configure()
    }
    
    func search(query: String, entity: String, completion: @escaping () -> Void) {
        view?.reloadCollectionView()
        view?.startAnimating()
        
        guard query.count >= 3 else {
            clearResults()
            view?.stopAnimating()
            completion()
            return
        }
        
        searchThrottle?.cancel()
        searchThrottle = Throttle(minimumDelay: 0.5)
        searchThrottle?.throttle { [weak self] in
            self?.networkingService.searchItunesAPI(withQuery: query, entity: entity, offset: 0, limit: self?.limit ?? 20) { [weak self] result in
                switch result {
                case .success(let results):
                    self?.searchResults = results
                    self?.createSection(model: results, query: query, entity: entity)
                case .failure(let error):
                    switch error {
                    case .invalidURL:
                        self?.view?.showErrorMessage("Invalid URL.")
                    case .noData:
                        self?.view?.showErrorMessage("No data received.")
                    case .decodingError:
                        self?.view?.showErrorMessage("Decoding error occurred.")
                    }
                }
                
                self?.view?.stopAnimating()
                self?.view?.reloadCollectionView()
                completion()
            }
        }
    }
    
    
    func loadMoreResults(query: String, entity: String, at indexPath: IndexPath, completion: @escaping () -> Void) {

        offset += limit
        networkingService.searchItunesAPI(withQuery: query, entity: entity, offset: offset, limit: limit) { [weak self] result in
            switch result {
            case .success(let results):
                self?.searchResults.append(contentsOf: results)
                self?.appendNewResults(results)
                self?.view?.reloadCollectionView()
            case .failure(let error):
                print("Error occurred while loading more results: \(error)")
            }
            completion()
        }
        view?.stopAnimating()
    }


    func numberOfResults() -> Int {
        return searchResults.count
    }
    
    func result(at index: Int) -> SearchResult? {
        guard index >= 0 && index < searchResults.count else {
            return nil
        }
        return searchResults[index]
    }

    func clearResults() {
        dataSource.sections = []
    }
}

private extension SearchViewModel {

    func createSection(model: [SearchResult], query: String, entity: String) {
        let loadMoreClosure: (() -> Void) = { [weak self] in
            guard let self = self else { return }
            let indexPath = IndexPath(item: self.numberOfResults() - 1, section: 0)
            self.loadMoreResults(query: query, entity: entity, at: indexPath) { }
        }
        
        let section = SearchListSection(cellModels: model, didSelectHandler: { [weak self] item in
            guard let self = self else { return }
            self.didSelectedItem(model: item)
        }, loadmoreDataHandler: loadMoreClosure)
        
        dataSource.sections = [section]
        view?.setDataSource(dataSource: dataSource)
    }
    
    func appendNewResults(_ newResults: [SearchResult]) {
        guard var section = dataSource.sections.first as? SearchListSection else { return }
        section.appendCellModels(newElements: newResults)
        dataSource.sections = [section]
        view?.reloadCollectionView()
    }
    
    func didSelectedItem(model: SearchResult) {
        let detailViewModel = DetailViewModel(searchResult: model)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        view?.pushViewController(viewController: detailViewController)
    }
}




