import Vapor

extension Payment {
    
    /// The reason that PayPal holds a recipient fund.
    public enum HoldReason: String, Hashable, CaseIterable, Content {
        
        /// `PAYMENT_HOLD`.
        case payment = "PAYMENT_HOLD"
        
        /// `SHIPPING_RISK_HOLD`.
        case shipping = "SHIPPING_RISK_HOLD"
    }
}
