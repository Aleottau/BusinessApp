//
//  ViewController.swift
//  BusinessApp
//
//  Created by alejandro on 5/03/23.
//

import UIKit
import SnapKit
import RxSwift

class HomeBusinnesViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel: ViewModelProtocol
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: CompositionalLayout().generateLayout())
    var homeDataSource: HomeDataSource?
  
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationBar()
        makeConstraints()
        getProductsFromDb()
        viewModel.rxProduct.asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] product in
            self?.homeDataSource?.addProduct(newProduct: product)
        }).disposed(by: disposeBag )
    }
    func getProductsFromDb() {
        viewModel.getProductsFromDb { [weak self] products in
            guard let collectionView = self?.collectionView else {
                return
            }
            self?.homeDataSource = HomeDataSource(collectionView: collectionView, products: products)
            self?.homeDataSource?.applySnapshot()
            collectionView.dataSource = self?.homeDataSource?.dataSource
            collectionView.delegate = self
        }
    }
    private func navigationBar() {
        navigationItem.title = "Lista de negocios"
        let addProduct = UIBarButtonItem(title: "", style: .done, target: self, action: #selector(addProduct) )
        addProduct.image = UIImage(systemName: "plus.circle")
        self.navigationItem.setRightBarButton(addProduct, animated: true)
        self.navigationItem.backButtonTitle = ""
        let backButton = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
        
        self.navigationItem.backBarButtonItem = backButton
    }
    @objc private func addProduct() {
        viewModel.presentAddProduct()
    }
    
    private func makeConstraints() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension HomeBusinnesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexCell = indexPath.row
        guard let product = homeDataSource?.products[indexCell] else {
            return
        }
        viewModel.presentProductDetailController(for: product)
    }
}
