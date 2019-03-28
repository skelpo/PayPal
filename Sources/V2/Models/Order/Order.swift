public struct Order: Codable { }

extension Order {
    
    /// The intent to either capture payment immediately or authorize a payment for an order after order creation.
    public enum Intent: String, Codable, Hashable, CaseIterable {
        
        /// The merchant intends to capture payment immediately after the customer makes a payment.
        case capture = "CAPTURE"
        
        /// The merchant intends to authorize a payment and place funds on hold after the customer makes a payment.
        /// Authorized payments are guaranteed for up to three days but are available to capture for up to 29 days.
        /// After the three-day honor period, the original authorized payment expires and you must re-authorize the payment.
        /// You must make a separate request to capture payments on demand.
        case authorize = "AUTHORIZE"
    }
}
