//
//  DiffableDataSource.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation
import UIKit

protocol HomeDataSourceProtocol {
    var dataSource: HomeDataSource.DiffDataSource { get }
    func applySnapshot(animatingDiff: Bool)
    
}
class HomeDataSource {
    var products: [ProductModel] = []
    var collectionView: UICollectionView
    typealias DiffDataSource = UICollectionViewDiffableDataSource<Section, Int32>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Int32>
    lazy var dataSource: HomeDataSource.DiffDataSource = makeDataSource()
    
    init(collectionView: UICollectionView, products: [ProductModel]) {
        self.collectionView = collectionView
        self.products = products
        registerCell(collection: collectionView, identifier: HomeBusinessCell.identifier)
    }
    private func registerCell(collection: UICollectionView, identifier: String) {
        let nib = UINib(nibName: identifier, bundle: nil)
        collection.register(nib, forCellWithReuseIdentifier: identifier )
    }
    private func modelFrom(itemIdentifier: Int32) -> ProductModel? {
        return products.first { $0.id == itemIdentifier }
    }
    
    private func makeDataSource() -> DiffDataSource {
        let dataSource = DiffDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBusinessCell.identifier, for: indexPath) as? HomeBusinessCell, let product = self?.modelFrom(itemIdentifier: itemIdentifier) else {
                return UICollectionViewCell()
            }
            cell.setModel(model: product)
            return cell
        }
        return dataSource
    }
}
extension HomeDataSource: HomeDataSourceProtocol {
    func applySnapshot(animatingDiff: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.home])
        snapshot.appendItems(products.map({ $0.id }), toSection: .home)
        dataSource.apply(snapshot, animatingDifferences: animatingDiff)
    }
    
    
}
