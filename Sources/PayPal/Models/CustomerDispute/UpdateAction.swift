import Vapor

/// Indicates whether the state change enables the customer or merchant to submit evidence:
public enum UpdateAction: String, Hashable, CaseIterable, Content {
    
    /// This will change the status of dispute to `WAITING_FOR_BUYER_RESPONSE`
    case buyer = "BUYER_EVIDENCE"
    
    /// This will change the status of dispute to `WAITING_FOR_SELLER_RESPONSE`
    case seller = "SELLER_EVIDENCE"
}
