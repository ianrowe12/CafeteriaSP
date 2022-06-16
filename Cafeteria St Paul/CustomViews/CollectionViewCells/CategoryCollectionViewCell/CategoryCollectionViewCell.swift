//
//  CategoryCollectionViewCell.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/26/22.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryTtitle: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }

    func setUp(category: DishCategory) {
        categoryImageView.image = category.image
        categoryTtitle.text = category.name
    }
}
