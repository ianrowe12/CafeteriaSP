//
//  SpecialDishCell.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/27/22.
//

import UIKit
import Kingfisher

class SpecialDishCell: UICollectionViewCell {

    
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishTitle: UILabel!
    @IBOutlet weak var specialPrice: UILabel!
    @IBOutlet weak var specialDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(specialDish: Dish) {
        dishTitle.text = specialDish.name
        specialPrice.text = specialDish.price
        specialDescription.text = specialDish.description
        dishImage.kf.setImage(with: URL(string: specialDish.imageURL))
    }

}
