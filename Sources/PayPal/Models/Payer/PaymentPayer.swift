import Vapor

extension BillingPayment {
    
    /// The source of the funds for a payment.
    public typealias Payer = PaymentPayer
}

extension Order {
    
    /// The source of the funds for a payment.
    public typealias Payer = PaymentPayer
}
    
/// The source of the funds for a payment.
public struct PaymentPayer: Content, Equatable {
    
    /// The status of payer's PayPal account.
    public let status: Status?
    
    
    /// The payment method.
    ///
    /// - Warning: The use of the PayPal REST `/payments` APIs to accept credit card payments is restricted.
    ///   Instead, you can accept credit card payments with:
    ///   - [Guest payments](https://developer.paypal.com/docs/integration/direct/payments/guest-payments/) with a
    ///     [credit card that is stored in the PayPal vault](https://developer.paypal.com/docs/api/vault/#credit-cards_create).
    ///   - [Braintree Direct](https://www.braintreepayments.com/products/braintree-direct)
    ///   - [PayPal business products](https://www.paypal.com/us/webapps/mpp/merchant)
    public var method: Method?
    
    /// An array of a single funding instrument for the current payment. Valid only and required for the credit card payment method.
    /// The array must include either a `credit_card` or `credit_card_token` object. If the array contains more than one instrument, the payment is declined.
    public var funding: [FundingInstrument]?
    
    /// The payer information.
    public var info: Info?
    
    
    /// Creates a new `Order.Payer` instance.
    ///
    /// - Parameters:
    ///   - method: The payment method.
    ///   - funding: An array of a single funding instrument for the current payment.
    public init(method: Method?, funding: [FundingInstrument]?, info: Info?) {
        self.status = nil
        self.method = method
        self.funding = funding
        self.info = info
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case method = "payment_method"
        case funding = "funding_instruments"
        case info = "payer_info"
    }
}
    
extension PaymentPayer {
    
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

extension PaymentPayer {
    
    /// The status of a payer's PayPal account.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// `VERIFIED`.
        case verified = "VERIFIED"
        
        /// `UNVERIFIED`.
        case unverified = "UNVERIFIED"
    }
}
