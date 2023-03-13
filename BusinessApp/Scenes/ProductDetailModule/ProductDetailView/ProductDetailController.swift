//
//  ProductDetailController.swift
//  BusinessApp
//
//  Created by alejandro on 9/03/23.
//

import UIKit
import SnapKit

class ProductDetailController: UIViewController {
    var productImage =  UIImageView()
    var lineTopImageDivision = UIImageView()
    var nameOfProduct = UILabel()
    var overview = UILabel()
    var lineBetweenOverviewPhoneNumer = UIImageView()
    var numberTitle = UILabel()
    var phoneNumber = UILabel()
    var lineBottonPhoneNumber = UIImageView()
    var scoreTitle = UILabel()
    var buttonDelete = UIButton()
    var product: ProductModel
    let viewModel: ViewModelProtocol
    
    init(product: ProductModel, viewModel: ViewModelProtocol, image: UIImage?) {
        self.product = product
        self.viewModel = viewModel
        self.productImage.image = image
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        makeConstraints()
        setUpViewComponents()
        deleteButtonAction()
    }
    private func setUpViewComponents() {
        lineTopImageDivision.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        nameOfProductConfig(label: nameOfProduct, text: product.nameProduct)
        overviewConfig(label: overview, text: product.overview)
        lineBetweenOverviewPhoneNumer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        defualtTitleConfig(label: numberTitle, text: "Número de teléfono")
        phoneNumberConfig(label: phoneNumber, text: product.phoneNumber)
        lineBottonPhoneNumber.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        defualtTitleConfig(label: scoreTitle, text: "Calificación")
        buttonDeleteConfig(button: buttonDelete)
    }
    
    private func makeConstraints() {
        view.addSubview(productImage)
        view.addSubview(lineTopImageDivision)
        view.addSubview(nameOfProduct)
        view.addSubview(overview)
        view.addSubview(lineBetweenOverviewPhoneNumer)
        view.addSubview(numberTitle)
        view.addSubview(phoneNumber)
        view.addSubview(lineBottonPhoneNumber)
        view.addSubview(scoreTitle)
        view.addSubview(buttonDelete)
        productImage.translatesAutoresizingMaskIntoConstraints = false
        lineTopImageDivision.translatesAutoresizingMaskIntoConstraints = false
        nameOfProduct.translatesAutoresizingMaskIntoConstraints = false
        overview.translatesAutoresizingMaskIntoConstraints = false
        lineBetweenOverviewPhoneNumer.translatesAutoresizingMaskIntoConstraints = false
        numberTitle.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        lineBottonPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        scoreTitle.translatesAutoresizingMaskIntoConstraints = false
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        productImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(220)
        }
        lineTopImageDivision.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).inset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(20)
        }
        nameOfProduct.snp.makeConstraints { make in
            make.top.equalTo(lineTopImageDivision.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
        overview.snp.makeConstraints { make in
            make.top.equalTo(nameOfProduct.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
        lineBetweenOverviewPhoneNumer.snp.makeConstraints { make in
            make.top.equalTo(overview.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(1)
        }
        numberTitle.snp.makeConstraints { make in
            make.top.equalTo(lineBetweenOverviewPhoneNumer.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
        phoneNumber.snp.makeConstraints { make in
            make.top.equalTo(numberTitle.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
        lineBottonPhoneNumber.snp.makeConstraints { make in
            make.top.equalTo(phoneNumber.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(1)
        }
        scoreTitle.snp.makeConstraints { make in
            make.top.equalTo(lineBottonPhoneNumber.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
        }
        buttonDelete.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(scoreTitle.snp.bottom).offset(100)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
        }
    }
    private func nameOfProductConfig(label: UILabel, text: String) {
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = text
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
    }
    private func overviewConfig(label: UILabel, text: String) {
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = text
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    }
    private func defualtTitleConfig(label: UILabel, text: String) {
        label.textAlignment = .left
        label.text = text
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    private func phoneNumberConfig(label: UILabel, text: String) {
        label.textAlignment = .left
        label.text = text
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    }
    private func buttonDeleteConfig(button: UIButton) {
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.cornerStyle = .capsule
        buttonConfig.background.backgroundColor = #colorLiteral(red: 0.8837971091, green: 0, blue: 0.02211552672, alpha: 1)
        button.configuration = buttonConfig
        button.setTitle("Eliminar Producto", for: .normal)
    }
    private func deleteButtonAction() {
        buttonDelete.addTarget(self, action: #selector(pressDeleteButton), for: .touchUpInside)
    }
    @objc private func pressDeleteButton() {
        viewModel.DeleteProductFromDb(id: product.id)
        viewModel.presentHomeView()
    }
}
