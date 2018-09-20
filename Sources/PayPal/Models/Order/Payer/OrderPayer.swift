import Vapor

extension Order {
    public struct Payer {}
}
    
extension Order.Payer {
    public enum Method: String, Hashable, CaseIterable, Content {
        
        /// Credit card.
        case creditCard = "credit_card"
        
        /// A PayPal Wallet payment.
        case paypal = "paypal"
        
        /// Pay upon invoice.
        case payUponInvoice = "pay_upon_invoice"
        
        /// Carrier.
        case carrier = "carrier"
        
        /// Alternate payment.
        case alternatePayment = "alternate_payment"
        
        /// Bank
        case bank = "bank"
    }
}
