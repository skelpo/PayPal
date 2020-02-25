extension Order {
    
    /// The status of an order.
    public enum Status: String, Hashable, Codable, CaseIterable {
        
        /// The order was created with the specified context.
        case CREATED
        
        /// The order was saved and persisted. The order status continues to be in progress until
        /// a capture is made with `final_capture = true` for all purchase units within the order.
        case SAVED
        
        /// The customer approved the payment through the PayPal wallet or another form of guest or unbranded payment.
        /// For example, a card, bank account, or so on.
        case APPROVED
        
        /// All purchase units in the order are voided.
        case VOIDED
        
        /// The payment was authorized or the authorized payment was captured for the order.
        case COMPLETED
    }
}
