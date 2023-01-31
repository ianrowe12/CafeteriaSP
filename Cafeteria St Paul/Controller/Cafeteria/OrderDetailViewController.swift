
import UIKit

class OrderDetailViewController: UIViewController {

    var order: Order?
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var orderNum: UILabel!
    @IBOutlet weak var retrievalDate: UILabel!
    @IBOutlet weak var dishLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Order"
        setupView(with: order!)
    }
    
    func setupView(with Order: Order) {
        DispatchQueue.main.async {
            self.orderNum.text = Order.orderNum
            self.retrievalDate.text = Order.date
            self.hourLabel.text = Order.hour
            self.dishLabel.text = Order.dishName
            self.userName.text = Order.userName
        }
    }

    
}
