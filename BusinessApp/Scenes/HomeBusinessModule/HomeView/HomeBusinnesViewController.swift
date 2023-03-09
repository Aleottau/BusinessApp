//
//  ViewController.swift
//  BusinessApp
//
//  Created by alejandro on 5/03/23.
//

import UIKit
import SnapKit

class HomeBusinnesViewController: UIViewController {

    let viewModel: ViewModelProtocol
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: CompositionalLayout().generateLayout())
    var setUpDataSource: HomeDataSource?
    var products: [ProductModel] = [ProductModel(id: 1, nameProduct: "producto 1", phoneNumber: "+57 300 555 6578", overview: "este producto es de buena calidad"),ProductModel(id: 2, nameProduct: "producto 2", phoneNumber: "+57 311 444 6578", overview: "este producto es de buena calidad"),ProductModel(id: 3, nameProduct: "producto 3", phoneNumber: "+57 322 333 6578", overview: "este producto es de buena calidad")]
    
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
        setUpDataSource = HomeDataSource(collectionView: collectionView, products: products)
        setUpDataSource?.applySnapshot()
        collectionView.dataSource = setUpDataSource?.dataSource
        
        // Do any additional setup after loading the view.
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

