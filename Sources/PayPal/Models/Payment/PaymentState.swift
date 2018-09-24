import Vapor

extension Payment {
    
    /// The state of a payment, authorization, or order transaction.
    public enum State: String, Hashable, CaseIterable, Content {
        
        /// The transaction was successfully created.
        case created
        
        /// The customer approved the transaction. The state changes from created to approved on generation of the `sale_id` for sale transactions,
        /// `authorization_id` for authorization transactions, or `order_id` for order transactions.
        case approved
        
        /// The transaction request failed.
        case failed
    }
}
