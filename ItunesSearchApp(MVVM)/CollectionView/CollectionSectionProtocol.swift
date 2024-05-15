//
//  CollectionSectionProtocol.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 13.05.2024.
//

import UIKit
protocol CollectionSectionProtocol {
    func registerCells(for collectionView: UICollectionView)
    func dequeReusableCell(in collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
    func numberOfCell() -> Int
    func sizeForItemAt(for collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, at indexPath: IndexPath) -> CGSize
    func minimumLineSpacingForSectionAt() -> CGFloat
    func minimumInteritemSpacingForSectionAt() -> CGFloat
    func insetForSectionAt(for collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, at section: Int) -> UIEdgeInsets
    func itemDidSelect(in collectionView: UICollectionView, at index: Int)
    func collectionViewWillDisplay(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forRowAt indexPath: IndexPath)
    func viewForSupplementaryElementOfKind(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    func referenceSizeForHeaderInSection(_ collectionView: UICollectionView, layout: UICollectionViewLayout, referenceSizeForHeaderInSection: Int) -> CGSize
    func referenceSizeForFooterInSection(_ collectionView: UICollectionView, layout: UICollectionViewLayout, referenceSizeForFooterInSection: Int) -> CGSize
}

extension CollectionSectionProtocol {
    func itemDidSelect(in collectionView: UICollectionView, at index: Int) {
        itemDidSelect(in: collectionView, at: index)
    }
    
    func collectionViewWillDisplay(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forRowAt indexPath: IndexPath) {
        collectionViewWillDisplay(collectionView, willDisplay: cell, forRowAt: indexPath)
    }
    
    func minimumLineSpacingForSectionAt() -> CGFloat {
        return .zero
    }
    
    func minimumInteritemSpacingForSectionAt() -> CGFloat {
        return .zero
    }
    
    func insetForSectionAt() -> UIEdgeInsets {
        return .zero
    }
    
    func insetForSectionAt(for collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, at section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func viewForSupplementaryElementOfKind(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
    
    func referenceSizeForHeaderInSection(_ collectionView: UICollectionView, layout: UICollectionViewLayout, referenceSizeForHeaderInSection: Int) -> CGSize {
        return .zero
    }
    
    func referenceSizeForFooterInSection(_ collectionView: UICollectionView, layout: UICollectionViewLayout, referenceSizeForFooterInSection: Int) -> CGSize {
        return .zero
    }
}
