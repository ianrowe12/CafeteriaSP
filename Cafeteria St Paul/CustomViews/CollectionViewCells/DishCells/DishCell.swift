//
//  DishCell.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/26/22.
//

import UIKit
import Kingfisher

class DishCell: UICollectionViewCell {
    
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(withTheDish popularDish: Dish) {
        titleLabel.text = popularDish.name
        priceLabel.text = popularDish.price
        descriptionLabel.text = popularDish.description
        dishImage.kf.setImage(with: URL(string: popularDish.imageURL))
    }

}
