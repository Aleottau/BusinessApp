//
//  AddProductController.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//
import Foundation
import UIKit
import SnapKit

class AddProductController: UIViewController {
    
    var titleLabel = UILabel()
    var name = UILabel()
    var nameTextField = UITextField()
    var phoneNumber = UILabel()
    var phoneNumberTextField = UITextField()
    var overview = UILabel()
    var overviewTextView = UITextView()
    var photo = UIButton()
    var addPhotoButton = UIButton()
    var saveButton = UIButton()
    // current data
    var currentName: String?
    var currentPhoneNumber: String?
    var currentOverview: String?
    var currentPickImage: UIImage?
    
    let viewModel: ViewModelProtocol
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func makeConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(name)
        view.addSubview(nameTextField)
        view.addSubview(phoneNumber)
        view.addSubview(phoneNumberTextField)
        view.addSubview(overview)
        view.addSubview(overviewTextView)
        view.addSubview(photo)
        view.addSubview(addPhotoButton)
        view.addSubview(saveButton)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        overview.translatesAutoresizingMaskIntoConstraints = false
        overviewTextView.translatesAutoresizingMaskIntoConstraints = false
        photo.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().inset(60)
        }
        name.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(100)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(name.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }
        phoneNumber.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(100)
        }
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumber.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
        }
        overview.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(100)
        }
        overviewTextView.snp.makeConstraints { make in
            make.top.equalTo(overview.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(40)
            make.height.equalTo(120)
        }
        photo.snp.makeConstraints { make in
            make.top.equalTo(overviewTextView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(150)
        }
        addPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(photo.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().inset(230)
        }
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(addPhotoButton.snp.bottom).offset(130)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        makeConstraints()
        setUpviewComponents()
        nameTextField.delegate = self
        phoneNumberTextField.delegate = self
        overviewTextView.delegate = self
        addPhoto()
        deletePhoto()
        saveButtonAction()
        photo.isEnabled = false
        photo.isHidden = true
    }
    
    private func setUpviewComponents() {
        titleLabelConfig(label: titleLabel, text: "Crear un negocio nuevo")
        defaulttLabelConfig(label: name, text: "Nombre")
        textFieldConfig(textField: nameTextField, text: "El nombre de tu negocio")
        defaulttLabelConfig(label: phoneNumber, text: "Telefono")
        textFieldConfig(textField: phoneNumberTextField, text: "Telefono celular")
        defaulttLabelConfig(label: overview, text: "Acerca de")
        overviewTextViewConfig(textView: overviewTextView, text: "Cuentanos sobre tu negocio")
        addButtonConfig(button: addPhotoButton)
        saveButtonConfig(button: saveButton, setTitle: "Guardar")
    }
    private func titleLabelConfig(label: UILabel, text: String) {
        label.textAlignment = .center
        label.text = text
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
    }
    private func defaulttLabelConfig(label: UILabel, text: String) {
        label.numberOfLines = 0
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
    }
    private func textFieldConfig(textField: UITextField, text: String) {
        textField.placeholder = text
        textField.clearsOnBeginEditing = true
        textField.borderStyle = .roundedRect
        textField.backgroundColor = #colorLiteral(red: 0.9668508172, green: 0.97679919, blue: 0.9895313382, alpha: 1)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    private func overviewTextViewConfig(textView: UITextView, text: String) {
        textView.text = text
        textView.backgroundColor = #colorLiteral(red: 0.9668508172, green: 0.97679919, blue: 0.9895313382, alpha: 1)
        textView.layer.borderWidth = 1/2
        textView.layer.borderColor = #colorLiteral(red: 0.8736239672, green: 0.8785962462, blue: 0.8914160728, alpha: 1)
        textView.layer.cornerRadius = 5
        textView.textColor = #colorLiteral(red: 0.7472397685, green: 0.7571908832, blue: 0.7699201703, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    private func photoButtonConfig(button: UIButton, setTitle: String) {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "xmark")
        config.imagePadding = 6
        config.imagePlacement = .leading
        config.title =  setTitle
        config.titleAlignment = .leading

        button.configuration = config
        button.setTitle(setTitle, for: .normal)
        button.setTitleColor( UIColor.gray , for: .normal)
        button.tintColor = UIColor.gray
    }
    private func addButtonConfig(button: UIButton) {
        button.setImage(UIImage(systemName: "paperclip"), for: .normal)
        button.setTitle("Agregar foto", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.tintColor = UIColor.blue
    }
    private func saveButtonConfig(button: UIButton, setTitle: String) {
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.cornerStyle = .large
        buttonConfig.background.backgroundColor = #colorLiteral(red: 0.1378852427, green: 0.8635071516, blue: 0.3454999924, alpha: 1)
        button.setTitle(setTitle, for: .normal)
        button.configuration = buttonConfig
    }
    private func getSubStringForPhoto(url: NSURL?) -> String {
        guard let text = url?.absoluteString else {
            return "defaulName.jpeg"
        }
        let start = text.index(text.startIndex, offsetBy: 36)
        let end = text.index(text.endIndex, offsetBy: -36)
        let range = start..<end
        return String(text[range])
    }
    
    private func addPhoto() {
        addPhotoButton.addTarget(self, action: #selector(pressAddPhoto), for: .touchUpInside)
    }
    @objc private func pressAddPhoto() {
        let pickController = UIImagePickerController()
        pickController.sourceType = .photoLibrary
        pickController.delegate = self
        pickController.allowsEditing = true
        present(pickController, animated: true)
    }
    private func deletePhoto() {
        photo.addTarget(self, action: #selector(pressDeletePhoto), for: .touchUpInside)
    }
    @objc private func pressDeletePhoto() {
        self.currentPickImage = nil
        self.photo.isHidden = true
        self.photo.isEnabled = false
    }
    
    private func saveButtonAction() {
        saveButton.addTarget(self, action: #selector(pressSaveButton), for: .touchUpInside)
    }
    @objc private func pressSaveButton() {
        guard let currentName = currentName, let currentPhoneNumber = currentPhoneNumber, let currentPickImage = currentPickImage else {
            showAlert()
            return
        }
        // cambiar a interactor
        let lastId = viewModel.getLastIdFromDb()
        let product = viewModel.createNewProduct(id: lastId, nameProduct: currentName, phoneNumber: currentPhoneNumber, overview: currentOverview ?? "")
        viewModel.saveProductInDb(product: product)
        viewModel.saveImageInLocalFile(image: currentPickImage, imageId: String(lastId))
        viewModel.presentHomeView()
    }
    private func showAlert() {
        lazy var alert = UIAlertController(title: "Ups", message: "Favor llenar todos los campos", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { _ in
        }))
        present(alert, animated: true)
    }
    

}

extension AddProductController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let imageFromGalery = info[.editedImage] as? UIImage else {
            return
        }
        self.currentPickImage = imageFromGalery
        let photoUrl = info[.referenceURL] as? NSURL
        let namePhoto = self.getSubStringForPhoto(url: photoUrl)
        self.photoButtonConfig(button: photo, setTitle: "\(namePhoto)" + ".jpeg")
        self.photo.isHidden = false
        self.photo.isEnabled = true
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if photo.isEnabled {
            picker.dismiss(animated: true)
        } else {
            self.photo.isHidden = true
            self.photo.isEnabled = false
            picker.dismiss(animated: true)
        }
    }
}


extension  AddProductController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if overviewTextView.text.isEmpty || overviewTextView.text == "Cuentanos sobre tu negocio" {
            self.currentOverview = nil
            overviewTextView.text = nil
            overviewTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            overviewTextView.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if overviewTextView.text.isEmpty {
            self.currentOverview = nil
            overviewTextView.textColor = #colorLiteral(red: 0.7472397685, green: 0.7571908832, blue: 0.7699201703, alpha: 1)
            overviewTextView.text =  "Cuentanos sobre tu negocio"
            
        } else {
            self.currentOverview = textView.text
        }
    }
}

extension AddProductController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.currentName = nameTextField.text
        self.currentPhoneNumber = phoneNumberTextField.text
    }
}
                   
