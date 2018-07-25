import Vapor

extension CustomerDispute {
    
    /// The stages in a customer dipute's life cycle.
    public enum LifeCycleStage: String, Hashable, CaseIterable, Content {
        
        /// A customer and merchant interact to resolve a dispute without escalation to PayPal.
        ///
        /// A dispute occurs when:
        /// - A customer has not received goods or a service.
        /// - The received goods or service are not as described.
        /// - The customer needs more details, such as a copy of the transaction or a receipt.
        case inquiry = "INQUIRY"
        
        /// A customer or merchant escalates an inquiry to a claim, which authorizes PayPal to investigate the case and make a determination.
        ///
        /// Occurs only when the dispute channel is `INTERNAL`. This stage is a PayPal dispute lifecycle stage and is not a credit card
        /// or debit card chargeback. All notes that the customer sends in this stage are visible to PayPal agents only.
        /// The customer must wait for PayPal’s response before he or she can take further action. In this stage, PayPal shares dispute details
        /// with the merchant, who can complete one of these actions:
        /// - Accept the claim.
        /// - Submit evidence to challenge the claim.
        /// - Make an offer to the customer to resolve the claim.
        case chargeback = "CHARGEBACK"
        
        /// The first appeal stage for merchants.
        ///
        /// A merchant can appeal a chargeback if PayPal's decision is not in the merchant's favor.
        /// If the merchant does not appeal within the appeal period, PayPal considers the case resolved.
        case preArbiration = "PRE_ARBITRATION"
        
        /// The second appeal stage for merchants.
        ///
        /// A merchant can appeal a dispute for a second time if PayPal denies the first appeal.
        /// If the merchant does not appeal within the appeal period, the case returns to a resolved status in the pre-arbitration stage.
        case arbitration = "ARBITRATION"
    }
}
