import Vapor

extension Order {
    
    /// The request body for the `POST /v1/checkout/orders/{order_id}/pay` endpoint, which is used to pay an order.
    public struct PaymentRequest: Content, Equatable {
        
        /// Indicates whether to disburse money instantly or later.
        public var disbursement: DisbursementMode
        
        /// The source of the funds for this payment. Either a PayPal account or a credit card.
        public var payer: Payer?
        
        
        /// Creates a new `Order.PaymentRequest` instance.
        ///
        /// - Parameters:
        ///   - disbursement: Indicates whether to disburse money instantly or later.
        ///   - payer: The source of the funds for this payment.
        public init(disbursement: DisbursementMode, payer: Payer?) {
            self.disbursement = disbursement
            self.payer = payer
        }
        
        enum CodingKeys: String, CodingKey {
            case disbursement = "disbursement_mode"
            case payer
        }
    }
}
