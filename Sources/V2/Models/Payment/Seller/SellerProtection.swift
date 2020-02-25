/// A transcation's protection level.
///
/// This will be defined for a transaction by the
/// [PayPal Seller Protection for Merchants](https://www.paypal.com/us/webapps/mpp/security/seller-protection).
public struct SellerProtection: Codable {
    
    /// Indicates whether the transaction is eligible for seller protection. For information,
    /// see [PayPal Seller Protection for Merchants](https://www.paypal.com/us/webapps/mpp/security/seller-protection).
    public let status: Status?
    
    /// An array of conditions that are covered for the transaction.
    public let disputes: [DisputeCategories]?
    
    /// Creates a new `SellerProtection` instance
    ///
    /// - Parameters:
    ///   - status: Indicates whether the transaction is eligible for seller protection.
    ///   - disputes: An array of conditions that are covered for the transaction.
    public init(status: Status?, disputes: [DisputeCategories]?) {
        self.status = status
        self.disputes = disputes
    }
    
    internal enum CodingKeys: String, CodingKey {
        case status
        case disputes = "dispute_categories"
    }
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
