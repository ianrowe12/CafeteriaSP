//
//  SettingsTableViewCell.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 6/20/22.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var settingTitle: UILabel!
    
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        accessoryType = .disclosureIndicator
//    }
//    
//    required init?(coder: NSCoder) {
//        
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//
//    }
    
    func setUpCell(setting: Setting) {
        settingTitle.text = setting.label
        cellImage.image = setting.image
    }
    
}
