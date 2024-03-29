//
//  DiffableDataSource.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation
import UIKit
import RxSwift

protocol HomeDataSourceProtocol {
    var dataSource: HomeDataSource.DiffDataSource { get }
    func applySnapshot(animatingDiff: Bool)
    
}
class HomeDataSource {
    let disposeBag = DisposeBag()
    var products: [ProductModel] = []
    var collectionView: UICollectionView
    var viewModel: ViewModelProtocol
    typealias DiffDataSource = UICollectionViewDiffableDataSource<Section, Int32>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Int32>
    lazy var dataSource: HomeDataSource.DiffDataSource = makeDataSource()
    
    init(collectionView: UICollectionView, products: [ProductModel], viewModel: ViewModelProtocol) {
        self.collectionView = collectionView
        self.products = products
        self.viewModel = viewModel
        registerCell(collection: collectionView, identifier: HomeBusinessCell.identifier)
        viewModel.rxCalification.asObservable()
            .subscribe(onNext: { [weak self] calification in
                self?.update(calification: calification)
            }).disposed(by: disposeBag)
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
            print(itemIdentifier)
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBusinessCell.identifier, for: indexPath) as? HomeBusinessCell, let product = self?.modelFrom(itemIdentifier: itemIdentifier) else {
                return UICollectionViewCell()
            }
            let imageFromLocalFile = self?.viewModel.getImageFromLocalFile(imageId: String(itemIdentifier))
            cell.setProductModel(model: product, imageFromLocalFile: imageFromLocalFile)
            cell.setCalificationModel(model: self?.viewModel.getCalificationFromDb(idProduct: itemIdentifier))
            return cell
        }
        return dataSource
    }
    func update(calification: CalificationModel) {
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems([calification.idProduct])
        dataSource.apply(snapshot)
    }
    func addProduct(newProduct: ProductModel) {
        products.append(newProduct)
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([newProduct.id], toSection: .home)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    func deleteProduct(idProduct: Int32) {
        guard let product = products.first(where: { $0.id == idProduct}) else {
            return
        }
        print(products)
        var snapshot = dataSource.snapshot()
        snapshot.deleteItems([product.id])
        self.applySnapshot()
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
