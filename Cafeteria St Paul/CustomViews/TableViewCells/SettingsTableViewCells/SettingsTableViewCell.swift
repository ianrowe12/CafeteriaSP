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

/*
 //
 //  SettingsTableViewCell.swift
 //  Cafeteria St Paul
 //
 //  Created by Ian Rowe on 6/20/22.
 //

 import UIKit

 class SlideSettingsTableViewCell: UITableViewCell {
     
     
     @IBOutlet weak var cellImage: UIImageView!
     @IBOutlet weak var settingTitle: UILabel!
     @IBOutlet var darkModeSwitch: UISwitch!
     
 //    override class func awakeFromNib() {
 //        super.awakeFromNib()
 //
   //}
     
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
     
     func setUpCell(setting: SlideSetting) {
         settingTitle.text = setting.label
         cellImage.image = setting.image
         darkModeSwitch.isOn = setting.darkMode
     }
     
     @IBAction func switchTapped(_ sender: UISwitch) {
         SceneDelegate.window?.overrideUserInterfaceStyle = sender.isOn == true ? .dark : .light
         
         if sender.isOn {
             UserDefaults.standard.setValue(true, forKey: "darkMode")
         } else {
             UserDefaults.standard.setValue(false, forKey: "darkMode")
         }
     }
     
 }

 */
