
import Foundation
import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {
    var paymentController: PKPaymentAuthorizationController?
    var PaymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?
    
    static let supportedNetworks: [PKPaymentNetwork] = [
        .visa,
        .masterCard,
        .amex,
        .vPay,
        .discover
    ]
    
    func startPayment(product: Dish, completion: @escaping PaymentCompletionHandler) {
        completionHandler = completion
        PaymentSummaryItems = []
        let price = 0
        let item = PKPaymentSummaryItem(label: product.name, amount: NSDecimalNumber(string: "\(product.price.dropFirst()).00"), type: .final)
        let Taxes = PKPaymentSummaryItem(label: "Estimated tax", amount: NSDecimalNumber(string: "150.00"), type: .final)
        
        let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "\(Int(product.price.dropFirst())!+150).00"), type: .final)
        
        PaymentSummaryItems.append(item)
        PaymentSummaryItems.append(Taxes)
        PaymentSummaryItems.append(total)
        
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = PaymentSummaryItems
        paymentRequest.merchantIdentifier = "merchant.com.ianrowe.cafeteriasp"
        //paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.merchantCapabilities = .capabilityCredit
        paymentRequest.merchantCapabilities = .capabilityDebit
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetworks
        paymentRequest.shippingType = .storePickup
        
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { presented in
            if presented {
                debugPrint("presented payment controller")
            } else {
                debugPrint("payment controller was not presented")
            }
        })
        
    }
}

extension PaymentHandler: PKPaymentAuthorizationControllerDelegate {
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let errors = [Error]()
        let status = PKPaymentAuthorizationStatus.success
        
        self.paymentStatus = status
        completion(PKPaymentAuthorizationResult(status: status, errors: errors))
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    if let completionHandler = self.completionHandler {
                        completionHandler(true)
                    }
                } else {
                    if let completionHandler = self.completionHandler {
                        completionHandler(false)
                    }
                }
            }
        }
    }
    
    
}
