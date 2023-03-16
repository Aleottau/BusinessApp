//
//  ProductDetailController.swift
//  BusinessApp
//
//  Created by alejandro on 9/03/23.
//

import UIKit
import SnapKit
import RxSwift

class ProductDetailController: UIViewController {

    let disposeBag = DisposeBag()
    var productImage =  UIImageView()
    var lineTopImageDivision = UIImageView()
    var nameOfProduct = UILabel()
    var overview = UILabel()
    var lineBetweenOverviewPhoneNumer = UIImageView()
    var numberTitle = UILabel()
    var phoneNumber = UILabel()
    var lineBottonPhoneNumber = UIImageView()
    var scoreTitle = UILabel()
    var buttonCalification = UIButton()
    var buttonDelete = UIButton()
    var product: ProductModel
    let viewModel: ViewModelProtocol
    
    var firstStar = UIButton()
    var secondStar = UIButton()
    var thirdStar = UIButton()
    var fourthStar = UIButton()
    var fifthStar = UIButton()
    var voteCount =  UILabel()
    
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
        addButtonsActions()
        getCalificationFromDb()
        rxGetCalification()
    }
    private func getCalificationFromDb() {
        guard let calification = viewModel.getCalificationFromDb(idProduct: product.id) else {
            return
        }
        rxConfigComponents(calificationModel: calification)
    }
    private func rxGetCalification() {
        viewModel.rxCalification
            .asObservable()
            .subscribe(onNext: { [weak self] calificacion in
                self?.rxConfigComponents(calificationModel: calificacion)
        }).disposed(by: disposeBag)
    }
    private func rxConfigComponents(calificationModel: CalificationModel) {
        switch calificationModel.promedio {
        case 1:
            starsButtonsConfig(button: firstStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: secondStar, imageSystemName: "star")
            starsButtonsConfig(button: thirdStar, imageSystemName: "star")
            starsButtonsConfig(button: fourthStar, imageSystemName: "star")
            starsButtonsConfig(button: fifthStar, imageSystemName: "star")
            voteCountConfig(label: voteCount, text: "(\(String(calificationModel.cantidadDeVotos)))")
        case 2:
            starsButtonsConfig(button: firstStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: secondStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: thirdStar, imageSystemName: "star")
            starsButtonsConfig(button: fourthStar, imageSystemName: "star")
            starsButtonsConfig(button: fifthStar, imageSystemName: "star")
            voteCountConfig(label: voteCount, text: "(\(String(calificationModel.cantidadDeVotos)))")
        case 3:
            starsButtonsConfig(button: firstStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: secondStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: thirdStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: fourthStar, imageSystemName: "star")
            starsButtonsConfig(button: fifthStar, imageSystemName: "star")
            voteCountConfig(label: voteCount, text: "(\(String(calificationModel.cantidadDeVotos)))")
        case 4:
            starsButtonsConfig(button: firstStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: secondStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: thirdStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: fourthStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: fifthStar, imageSystemName: "star")
            voteCountConfig(label: voteCount, text: "(\(String(calificationModel.cantidadDeVotos)))")
        case 5:
            starsButtonsConfig(button: firstStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: secondStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: thirdStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: fourthStar, imageSystemName: "star.fill")
            starsButtonsConfig(button: fifthStar, imageSystemName: "star.fill")
            voteCountConfig(label: voteCount, text: "(\(String(calificationModel.cantidadDeVotos)))")
        default:
            print("default swift rxCalification")
        }
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
        buttonCalificationConfig(button: buttonCalification)
        buttonDeleteConfig(button: buttonDelete)
        starsButtonsConfig(button: firstStar, imageSystemName: "star")
        starsButtonsConfig(button: secondStar, imageSystemName: "star")
        starsButtonsConfig(button: thirdStar, imageSystemName: "star")
        starsButtonsConfig(button: fourthStar, imageSystemName: "star")
        starsButtonsConfig(button: fifthStar, imageSystemName: "star")
        voteCountConfig(label: voteCount, text: "(0)")
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
        view.addSubview(firstStar)
        view.addSubview(secondStar)
        view.addSubview(thirdStar)
        view.addSubview(fourthStar)
        view.addSubview(fifthStar)
        view.addSubview(voteCount)
        view.addSubview(buttonCalification)
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
        firstStar.translatesAutoresizingMaskIntoConstraints = false
        secondStar.translatesAutoresizingMaskIntoConstraints = false
        thirdStar.translatesAutoresizingMaskIntoConstraints = false
        fourthStar.translatesAutoresizingMaskIntoConstraints = false
        fifthStar.translatesAutoresizingMaskIntoConstraints = false
        voteCount.translatesAutoresizingMaskIntoConstraints = false
        buttonCalification.translatesAutoresizingMaskIntoConstraints = false
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
        firstStar.snp.makeConstraints { make in
            make.top.equalTo(scoreTitle.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
        }
        secondStar.snp.makeConstraints { make in
            make.top.equalTo(scoreTitle.snp.bottom).offset(20)
            make.leading.equalTo(firstStar.snp.trailing)
        }
        thirdStar.snp.makeConstraints { make in
            make.top.equalTo(scoreTitle.snp.bottom).offset(20)
            make.leading.equalTo(secondStar.snp.trailing)
        }
        fourthStar.snp.makeConstraints { make in
            make.top.equalTo(scoreTitle.snp.bottom).offset(20)
            make.leading.equalTo(thirdStar.snp.trailing)
        }
        fifthStar.snp.makeConstraints { make in
            make.top.equalTo(scoreTitle.snp.bottom).offset(20)
            make.leading.equalTo(fourthStar.snp.trailing)
            make.trailing.equalToSuperview().inset(202)
        }
        voteCount.snp.makeConstraints { make in
            make.top.equalTo(scoreTitle.snp.bottom).offset(20)
            make.leading.equalTo(fifthStar.snp.trailing).offset(20)
            make.trailing.equalToSuperview().inset(30)
        }
        buttonCalification.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(firstStar.snp.bottom).offset(100)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
        }
        buttonDelete.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(buttonCalification.snp.bottom).offset(20)
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
    private func voteCountConfig(label: UILabel, text: String) {
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = text
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
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
    private func buttonCalificationConfig(button: UIButton) {
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.cornerStyle = .capsule
        buttonConfig.background.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        button.configuration = buttonConfig
        button.setTitle("Agregar calificación", for: .normal)
    }
    private func starsButtonsConfig(button: UIButton, imageSystemName: String) {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .all
        config.image = UIImage(systemName: imageSystemName)
        config.imagePadding = .zero
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button.configuration = config
        button.tintColor = UIColor.black
    }
    private func addButtonsActions() {
        buttonDelete.addTarget(self, action: #selector(pressDeleteButton), for: .touchUpInside)
        buttonCalification.addTarget(self, action: #selector(pressCalificationButton), for: .touchUpInside)
    }
    @objc private func pressDeleteButton() {
        viewModel.DeleteProductFromDb(id: product.id)
        viewModel.deleteImageFromLocalFile(idProduct: product.id)
        viewModel.presentHomeView()
    }
    @objc private func pressCalificationButton() {
        allComponentsConfigWhenPressCalificationButton()
        showAlert()
    }
    private func showAlert() {
        let alertView = CalificationView(detailController: self)
        alertView.backgroundColor = .white
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(350)
        }
    }
    private func allComponentsConfigWhenPressCalificationButton() {
        view.backgroundColor = UIColor(white: 0.8, alpha: 0.8)
        buttonDelete.isEnabled = false
        buttonDelete.alpha = 0.5
        buttonCalification.isEnabled = false
        buttonCalification.alpha = 0.5
        productImage.alpha = 0.5
        lineTopImageDivision.backgroundColor = UIColor(white: 0.4, alpha: 0.8)
        lineBetweenOverviewPhoneNumer.backgroundColor = UIColor(white: 0.4, alpha: 0.8)
        lineBottonPhoneNumber.backgroundColor = UIColor(white: 0.4, alpha: 0.8)
    }
    
}
