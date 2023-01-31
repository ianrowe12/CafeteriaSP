
import Foundation

struct K {
        
    struct settingsLabels {
        static let email = "Change Email"
        static let password = "Change Password"
        static let id = "Change carné"
        static let username = "Change Username"
    }
    
    struct Cells {
        struct tableViewCell{
            static let orderCell = "OrderTableViewCell"
            static let settingsCell = "SettingsTableViewCell"
            static let dishListCell = "DishListTableCell"
        }
        struct collectionViewCell {
            static let dishCell = "DishCell"
            static let categoryCell = "CategoryCollectionViewCell"
            static let specialDishCell = "SpecialDishCell"
        }
    }
    struct timeString {
        static let morning = "Before 7 a.m"
        static let snack = "Snack Break"
        static let lunch = "Lunch Break"
        static let afternoon = "2 p.m Break"
    }
    
    struct timeNum {
        static let sevenAM: Double = 7*60*60
        static let nineAM: Double = 9*60*60
        static let elevenAM: Double = 11*60*60
        static let twoPM: Double = 14*60*60
    }
}

