//
//  CalificationView.swift
//  BusinessApp
//
//  Created by alejandro on 13/03/23.
//

import UIKit

class CalificationView: UIView {

    var alertTitle = UILabel()
    var firstStar = UIButton()
    var secondStar = UIButton()
    var thirdStar = UIButton()
    var fourthStar = UIButton()
    var fifthStar = UIButton()
   var saveButton = UIButton()
    var currentVote: Int32?
    
    weak var detailController: ProductDetailController?
    init(detailController: ProductDetailController) {
        self.detailController = detailController
        super.init(frame: .zero)
        alertViewConfig()
        alertViewComponentsConstraints()
        setUpComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpComponents() {
        alertTitleConfig(label: alertTitle, text: "Agregar Calificación")
        starsButtonsConfig(button: firstStar, imageSystem: "star")
        starsButtonsConfig(button: secondStar, imageSystem: "star")
        starsButtonsConfig(button: thirdStar, imageSystem: "star")
        starsButtonsConfig(button: fourthStar, imageSystem: "star")
        starsButtonsConfig(button: fifthStar, imageSystem: "star")
        saveButtonConfig(button: saveButton, setTitle: "Guardar")
        saveButton.addTarget(self, action: #selector(pressSaveButton), for: .touchUpInside)
        firstStar.addTarget(self, action: #selector(pressFirstStar), for: .touchUpInside)
        secondStar.addTarget(self, action: #selector(pressSecondStar), for: .touchUpInside)
        thirdStar.addTarget(self, action: #selector(pressThirdStar), for: .touchUpInside)
        fourthStar.addTarget(self, action: #selector(pressFourthStar), for: .touchUpInside)
        fifthStar.addTarget(self, action: #selector(pressFifthStar), for: .touchUpInside)
    }
    private func alertViewComponentsConstraints() {
        addSubview(alertTitle)
        addSubview(firstStar)
        addSubview(secondStar)
        addSubview(thirdStar)
        addSubview(fourthStar)
        addSubview(fifthStar)
        addSubview(saveButton)
        alertTitle.translatesAutoresizingMaskIntoConstraints = false
        firstStar.translatesAutoresizingMaskIntoConstraints = false
        secondStar.translatesAutoresizingMaskIntoConstraints = false
        thirdStar.translatesAutoresizingMaskIntoConstraints = false
        fourthStar.translatesAutoresizingMaskIntoConstraints = false
        fifthStar.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        alertTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        firstStar.snp.makeConstraints { make in
            make.top.equalTo(alertTitle.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(75)
        }
        secondStar.snp.makeConstraints { make in
            make.top.equalTo(alertTitle.snp.bottom).offset(50)
            make.leading.equalTo(firstStar.snp.trailing)
        }
        thirdStar.snp.makeConstraints { make in
            make.top.equalTo(alertTitle.snp.bottom).offset(50)
            make.leading.equalTo(secondStar.snp.trailing)
        }
        fourthStar.snp.makeConstraints { make in
            make.top.equalTo(alertTitle.snp.bottom).offset(50)
            make.leading.equalTo(thirdStar.snp.trailing)
        }
        fifthStar.snp.makeConstraints { make in
            make.top.equalTo(alertTitle.snp.bottom).offset(50)
            make.leading.equalTo(fourthStar.snp.trailing)
            make.trailing.equalToSuperview().inset(77)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(fifthStar.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(45)
        }
    }
    private func alertViewConfig() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
    }
    private func alertTitleConfig(label: UILabel, text: String) {
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = text
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
    }

    private func starsButtonsConfig(button: UIButton, imageSystem: String) {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .all
        config.image = UIImage(systemName: imageSystem)
        config.imagePadding = .zero
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button.configuration = config
        button.tintColor = .black
    }
    private func saveButtonConfig(button: UIButton, setTitle: String) {
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.cornerStyle = .large
        buttonConfig.background.backgroundColor = #colorLiteral(red: 0.1378852427, green: 0.8635071516, blue: 0.3454999924, alpha: 1)
        button.setTitle(setTitle, for: .normal)
        button.configuration = buttonConfig
    }
    
    @objc private func pressSaveButton() {
        if currentVote == nil {
            configAllComponentsInPrincipalView()
            self.removeFromSuperview()
        } else {
            guard let id = detailController?.product.id, let currentVote = self.currentVote else {
               return
            }
            detailController?.viewModel.saveCalification(with: id, currentVote: currentVote)
            configAllComponentsInPrincipalView()
            self.removeFromSuperview()
        }
    }
    private func configAllComponentsInPrincipalView() {
        detailController?.view.backgroundColor = UIColor(white: 1, alpha: 1)
        detailController?.buttonCalification.isEnabled = true
        detailController?.buttonCalification.alpha = 1
        detailController?.buttonDelete.isEnabled = true
        detailController?.buttonDelete.alpha = 1
        detailController?.productImage.alpha = 1
        detailController?.lineTopImageDivision.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        detailController?.lineBetweenOverviewPhoneNumer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        detailController?.lineBottonPhoneNumber.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    @objc private func pressFirstStar() {
        currentVote = 1
        starsButtonsConfig(button: firstStar, imageSystem: "star.fill")
        starsButtonsConfig(button: secondStar, imageSystem: "star")
        starsButtonsConfig(button: thirdStar, imageSystem: "star")
        starsButtonsConfig(button: fourthStar, imageSystem: "star")
        starsButtonsConfig(button: fifthStar, imageSystem: "star")
        
    }
    @objc private func pressSecondStar() {
        currentVote = 2
        starsButtonsConfig(button: firstStar, imageSystem: "star.fill")
        starsButtonsConfig(button: secondStar, imageSystem: "star.fill")
        starsButtonsConfig(button: thirdStar, imageSystem: "star")
        starsButtonsConfig(button: fourthStar, imageSystem: "star")
        starsButtonsConfig(button: fifthStar, imageSystem: "star")
    }
    @objc private func pressThirdStar() {
        currentVote = 3
        starsButtonsConfig(button: firstStar, imageSystem: "star.fill")
        starsButtonsConfig(button: secondStar, imageSystem: "star.fill")
        starsButtonsConfig(button: thirdStar, imageSystem: "star.fill")
        starsButtonsConfig(button: fourthStar, imageSystem: "star")
        starsButtonsConfig(button: fifthStar, imageSystem: "star")
    }
    @objc private func pressFourthStar() {
        currentVote = 4
        starsButtonsConfig(button: firstStar, imageSystem: "star.fill")
        starsButtonsConfig(button: secondStar, imageSystem: "star.fill")
        starsButtonsConfig(button: thirdStar, imageSystem: "star.fill")
        starsButtonsConfig(button: fourthStar, imageSystem: "star.fill")
        starsButtonsConfig(button: fifthStar, imageSystem: "star")
    }
    @objc private func pressFifthStar() {
        currentVote = 5
        starsButtonsConfig(button: firstStar, imageSystem: "star.fill")
        starsButtonsConfig(button: secondStar, imageSystem: "star.fill")
        starsButtonsConfig(button: thirdStar, imageSystem: "star.fill")
        starsButtonsConfig(button: fourthStar, imageSystem: "star.fill")
        starsButtonsConfig(button: fifthStar, imageSystem: "star.fill")
    }
}
