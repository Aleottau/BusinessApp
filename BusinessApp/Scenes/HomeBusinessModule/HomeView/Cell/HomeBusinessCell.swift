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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    }
    
    func setModel(model: ProductModel) {
        titleLabel.text = model.title
        phoneNumberLabel.text = model.phoneNumber
        overviewLabel.text = model.overview
    }
}
