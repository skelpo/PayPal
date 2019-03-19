public struct SellerProtection: Codable {
    
}

extension SellerProtection {
    
    /// The dispute conditions that can be covered by a transaction.
    public enum DisputeCategories: String, Hashable, Codable, CaseIterable {
        /// The payer paid for an item that he or she did not receive.
        case itemNotReceived = "ITEM_NOT_RECEIVED"
        
        /// The payer did not authorize the payment.
        case unauthorizedTransaction = "UNAUTHORIZED_TRANSACTION"
    }
}
