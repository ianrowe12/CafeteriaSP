//
//  CardView.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 5/26/22.
//

import Foundation
import UIKit

//We will use this class as the class used for the collection view cell
//We have to remove the clips to bounds properties from the cell so that we can actually see the shadow
class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero //So that it doesnt have any particular angle.
        layer.cornerRadius = 10
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        
    }
}
