import Vapor

extension Order {
    
    /// Redirect URLs for PayPal payments when a payment is approved of canceled.
    public struct Redirects: Content, Equatable {
        
        /// The URL where the payer is redirected after the payer approves the payment.
        public var `return`: String?
        
        /// The URL where the payer is redirected after the payer cancels the payment.
        public var cancel: String?
        
        /// Creates a new `Order.Redirects` instance.
        ///
        /// - Parameters:
        ///   - return: The URL where the payer is redirected after the payer approves the payment.
        ///   - cancel: The URL where the payer is redirected after the payer cancels the payment.
        public init(`return`: String?, cancel: String?) {
            self.return = `return`
            self.cancel = cancel
        }
    }
}
