//
//  CalificationViewController.swift
//  BusinessApp
//
//  Created by alejandro on 13/03/23.
//

import UIKit
import SnapKit

class CalificationViewController: UIViewController {
    var alertView = UIView()
    
    var alertTitle = UILabel()
    var firstStar = UIButton()
    var secondStar = UIButton()
    var thirdStar = UIButton()
    var fourthStar = UIButton()
    var fifthStar = UIButton()
   var saveButton = UIButton()
    var currentVote: Int32?
    
    var viewModel: ViewModelProtocol
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        alertViewConstraints()
        alertViewConfig()
        alertViewComponentsConstraints()
        setUpComponents()
        
    }
    private func setUpComponents() {
        alertTitleConfig(label: alertTitle, text: "Agregar Calificación")
        starsButtonsConfig(button: firstStar, imageSystem: "star")
        starsButtonsConfig(button: secondStar, imageSystem: "star")
        starsButtonsConfig(button: thirdStar, imageSystem: "star")
        starsButtonsConfig(button: fourthStar, imageSystem: "star")
        starsButtonsConfig(button: fifthStar, imageSystem: "star")
        saveButtonConfig(button: saveButton, setTitle: "Guardar")
        saveButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        firstStar.addTarget(self, action: #selector(pressFirstStar), for: .touchUpInside)
        secondStar.addTarget(self, action: #selector(pressSecondStar), for: .touchUpInside)
        thirdStar.addTarget(self, action: #selector(pressThirdStar), for: .touchUpInside)
        fourthStar.addTarget(self, action: #selector(pressFourthStar), for: .touchUpInside)
        fifthStar.addTarget(self, action: #selector(pressFifthStar), for: .touchUpInside)
    }
    private func alertViewConstraints() {
        view.addSubview(alertView)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(300)
        }
    }
    private func alertViewComponentsConstraints() {
        alertView.addSubview(alertTitle)
        alertView.addSubview(firstStar)
        alertView.addSubview(secondStar)
        alertView.addSubview(thirdStar)
        alertView.addSubview(fourthStar)
        alertView.addSubview(fifthStar)
        alertView.addSubview(saveButton)
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
        alertView.backgroundColor = .white
        alertView.layer.cornerRadius = 20
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
    
    @objc private func pressButton() {
        view.removeFromSuperview()
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

extension CalificationViewController: UIViewControllerTransitioningDelegate {
    
}
