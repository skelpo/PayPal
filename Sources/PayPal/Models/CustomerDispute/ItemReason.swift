import Vapor

extension Item {
    
    /// The reason for the item-level dispute.
    public enum Reason: String, Hashable, CaseIterable, Content {
        
        /// The customer did not receive the merchandise or service.
        case notReceived = "MERCHANDISE_OR_SERVICE_NOT_RECEIVED"
        
        /// The customer reports that the merchandise or service is not as described.
        case notAsDescribed = "MERCHANDISE_OR_SERVICE_NOT_AS_DESCRIBED"
        
        /// The customer did not authorize purchase of the merchandise or service.
        case unauthorized = "UNAUTHORISED"
        
        /// The refund or credit was not processed for the customer.
        case notProcessed = "CREDIT_NOT_PROCESSED"
        
        /// The transaction was a duplicate.
        case duplicate = "DUPLICATE_TRANSACTION"
        
        /// The customer was charged an incorrect amount.
        case incorrectAmount = "INCORRECT_AMOUNT"
        
        /// The customer paid for the transaction through other means.
        case paymentByOtherMeans = "PAYMENT_BY_OTHER_MEANS"
        
        /// The customer was being charged for a subscription or a recurring transaction that was canceled.
        case reacurringCancelled = "CANCELED_RECURRING_BILLING"
        
        /// A problem occurred with the remittance.
        case remittanceIssue = "PROBLEM_WITH_REMITTANCE"
        
        /// Other.
        case other = "OTHER"
    }
}
