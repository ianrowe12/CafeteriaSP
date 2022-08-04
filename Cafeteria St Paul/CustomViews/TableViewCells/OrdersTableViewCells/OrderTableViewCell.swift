//
//  OrderTableViewCell.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 6/27/22.
//

import UIKit
import Kingfisher

class OrderTableViewCell: UITableViewCell {

    override class func awakeFromNib() {
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    @IBOutlet weak var orderImage: UIImageView!
    @IBOutlet weak var orderName: UILabel!    
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderNum: UILabel!
    
    func setupCell(with Order: Order) {
        orderName.text = Order.dishName
        orderDate.text = Order.date
        orderNum.text = "Order #\(Order.orderNum)"
        orderImage.kf.setImage(with: URL(string: Order.imageURL))
    }
}
