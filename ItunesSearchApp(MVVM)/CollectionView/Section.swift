//
//  Section.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 13.05.2024.
//

import Foundation
import UIKit

struct SearchListSection {
    var cellModels: [SearchResult]
    let didSelectHandler: ((SearchResult) -> ())?
    let loadmoreDataHandler: (() -> Void)?
    
    mutating func appendCellModels(newElements: [SearchResult]) {
        cellModels.append(contentsOf: newElements)
    }
}

extension SearchListSection: CollectionSectionProtocol {
    
    func numberOfCell() -> Int {
        return cellModels.count
    }
    
    func itemDidSelect(in collectionView: UICollectionView, at index: Int) {
        didSelectHandler?(cellModels[index])
    }
    
    func registerCells(for collectionView: UICollectionView) {
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCollectionViewCell")
    }
    
    func dequeReusableCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CustomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        let model = cellModels[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func sizeForItemAt(for collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, at indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 2
        let height: CGFloat = 200
        return CGSize(width: width, height: height)
    }
    
    func collectionViewWillDisplay(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == cellModels.count - 1 && cellModels.count > 19 {
            loadmoreDataHandler?()
            }
        }
}
