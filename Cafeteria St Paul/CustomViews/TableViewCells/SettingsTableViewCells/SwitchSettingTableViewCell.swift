//
//  SwitchSettingTableViewCell.swift
//  Cafeteria St Paul
//
//  Created by Ian Rowe on 7/5/22.
//

import UIKit

class SwitchSettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellSwitch: UISwitch!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(setting: SlideSetting) {
        cellLabel.text = setting.label
        cellImage.image = setting.image
        cellSwitch.isOn = setting.darkMode
    }
    
    @IBAction func SwitchTapped(_ sender: UISwitch) {
        SceneDelegate.window?.overrideUserInterfaceStyle = sender.isOn == true ? .dark : .light
        
        if sender.isOn {
            UserDefaults.standard.setValue(true, forKey: "darkMode")
        } else {
            UserDefaults.standard.setValue(false, forKey: "darkMode")
        }
    }
    
}
