import Vapor

extension Order {
    public struct Payer: Content, Equatable {
        public let status: Status?
        
        public var method: Method?
        public var funding: [FundingInstrument]?
        public var info: Info?
        
        public init(method: Method?, funding: [FundingInstrument]?, info: Info?) {
            self.status = nil
            self.method = method
            self.funding = funding
            self.info = info
        }
    }
}
    
extension Order.Payer {
    
    /// The payment method used by a payer in an order.
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

extension Order.Payer {
    
    /// The status of a payer's PayPal account.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// `VERIFIED`.
        case verified = "VERIFIED"
        
        /// `UNVERIFIED`.
        case unverified = "UNVERIFIED"
    }
}
