//
//  DataSource.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 13.05.2024.
//
import UIKit

final class DataSource: NSObject {
    var sections: [CollectionSectionProtocol] = []
    
    func updateSections(newSections: [CollectionSectionProtocol]) {
        self.sections = newSections
    }
}

extension DataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return sections[indexPath.section].sizeForItemAt(for: collectionView, layout: layout, at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sections[section].minimumLineSpacingForSectionAt()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sections[section].minimumInteritemSpacingForSectionAt()
    }
}

extension DataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sections[indexPath.section].itemDidSelect(in: collectionView, at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        sections[indexPath.section].collectionViewWillDisplay(collectionView, willDisplay: cell, forRowAt: indexPath)
    }
}

extension DataSource: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].dequeReusableCell(in: collectionView, at: indexPath)
    }
}


