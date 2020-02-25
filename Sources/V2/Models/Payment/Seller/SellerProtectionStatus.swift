extension SellerProtection {
    
    /// The transaction eligibility statuses for seller protection.
    public enum Status: String, Hashable, Codable, CaseIterable {
        /// Your PayPal balance remains intact if the customer claims that he or she did not
        /// receive an item or the account holder claims that he or she did not authorize the payment.
        case eligible = "ELIGIBLE"
        
        /// Your PayPal balance remains intact if the customer claims that he or she did not receive an item.
        case partiallyEligible = "PARTIALLY_ELIGIBLE"
        
        /// This transaction is not eligible for seller protection.
        case notEligible = "NOT_ELIGIBLE"
    }
}
