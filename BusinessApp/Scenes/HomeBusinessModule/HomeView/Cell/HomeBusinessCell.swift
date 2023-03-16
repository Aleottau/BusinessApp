//
//  HomeBusinessCell.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import UIKit

class HomeBusinessCell: UICollectionViewCell {
    
    static let identifier: String = "HomeBusinessCell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var firstStar: UIButton!
    @IBOutlet weak var secondStar: UIButton!
    @IBOutlet weak var thirdStar: UIButton!
    @IBOutlet weak var fourthStar: UIButton!
    @IBOutlet weak var fifthStar: UIButton!
    @IBOutlet weak var voteCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpProductImage()
    }
    
    override var reuseIdentifier: String? {
        return HomeBusinessCell.identifier
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        phoneNumberLabel.text = nil
        overviewLabel.text = nil
        productImage.image = nil
        firstStar.setImage(nil, for: .normal)
        secondStar.setImage(nil, for: .normal)
        thirdStar.setImage(nil, for: .normal)
        fourthStar.setImage(nil, for: .normal)
        fifthStar.setImage(nil, for: .normal)
        voteCount.text = nil
    }
    private func setUpProductImage() {
        productImage.layer.borderWidth = 3
        productImage.layer.borderColor = #colorLiteral(red: 0.8823530078, green: 0.8823530078, blue: 0.8823530078, alpha: 0.2111703228)
        productImage.layer.cornerRadius = 10
        productImage.layer.shadowRadius = 20
        productImage.layer.shadowColor = UIColor.gray.cgColor
        productImage.layer.shadowOpacity = 0.5
    }
    
    func setProductModel(model: ProductModel, imageFromLocalFile: UIImage?) {
        titleLabel.text = model.nameProduct
        phoneNumberLabel.text = model.phoneNumber
        overviewLabel.text = model.overview
        productImage.image = imageFromLocalFile
    }
    func setCalificationModel(model: CalificationModel?) {
        guard let model = model else {
            return
        }
        switch model.promedio {
        case 1:
            firstStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            secondStar.setImage(UIImage(systemName: "star"), for: .normal)
            thirdStar.setImage(UIImage(systemName: "star"), for: .normal)
            fourthStar.setImage(UIImage(systemName: "star"), for: .normal)
            fifthStar.setImage(UIImage(systemName: "star"), for: .normal)
            voteCount.text = "(\(String(model.cantidadDeVotos)))"
        case 2:
            firstStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            secondStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            thirdStar.setImage(UIImage(systemName: "star"), for: .normal)
            fourthStar.setImage(UIImage(systemName: "star"), for: .normal)
            fifthStar.setImage(UIImage(systemName: "star"), for: .normal)
            voteCount.text = "(\(String(model.cantidadDeVotos)))"
        case 3:
            firstStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            secondStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            thirdStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            fourthStar.setImage(UIImage(systemName: "star"), for: .normal)
            fifthStar.setImage(UIImage(systemName: "star"), for: .normal)
            voteCount.text = "(\(String(model.cantidadDeVotos)))"
        case 4:
            firstStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            secondStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            thirdStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            fourthStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            fifthStar.setImage(UIImage(systemName: "star"), for: .normal)
            voteCount.text = "(\(String(model.cantidadDeVotos)))"
        case 5:
            firstStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            secondStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            thirdStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            fourthStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            fifthStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
            voteCount.text = "(\(String(model.cantidadDeVotos)))"
        default:
            print("default swift rxCalification")
        }
    }
}
