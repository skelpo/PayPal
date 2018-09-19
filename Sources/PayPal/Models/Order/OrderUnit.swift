import Vapor

extension Order {
    public struct Unit {}
}

extension Order.Unit {
    
    /// The transaction state of a purchase unit.
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The transaction was not processed.
        case notProcessed = "NOT_PROCESSED"
        
        /// The transaction is pending.
        case pending = "PENDING"
        
        /// The transaction was declined and voided.
        case voided = "VOIDED"
        
        /// Payment for the transaction was not authorized.
        case authorized = "AUTHORIZED"
        
        /// Payment for the transaction was captured or is pending capture.
        case captured = "CAPTURED"
    }
}

extension Order.Unit {
    
    /// The reason code for a transaction status of `PENDING` or `REVERSED`. 
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// The transaction state is `PENDING` or `REVERSED` due to an unconfirmed payer shipping address.
        case unconfirmedAddress = "PAYER_SHIPPING_UNCONFIRMED"
        
        /// The transaction state is `PENDING` or `REVERSED` because it is a multi-currency transaction.
        case multiCurrency = "MULTI_CURRENCY"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a risk review.
        case risk = "RISK_REVIEW"
        
        /// The transaction state is `PENDING` or `REVERSED` due to a regulatory review.
        case regulatory = "REGULATORY_REVIEW"
        
        /// The transaction state is `PENDING` or `REVERSED` because verification is required.
        case verification = "VERIFICATION_REQUIRED"
        
        /// The transaction state is `PENDING` or `REVERSED` because the transaction is an order.
        case order = "ORDER"
        
        /// The transaction state is `PENDING` or `REVERSED` due to another reason.
        case other = "OTHER"
        
        /// The transaction state is `PENDING` or `REVERSED` because it was declined by a policy.
        case declinedByPolicy = "DECLINED_BY_POLICY"
    }
}
