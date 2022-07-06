//
//  WelcomeCollectionViewCell.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 7/3/22.
//

import UIKit

class WelcomeCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!
    @IBOutlet weak var slideDescription: UILabel!
    
    func setupCell(page: WelcomePage) {
        pageImage.image = page.image
        slideTitle.text = page.title
        slideDescription.text = page.description
    }
}
