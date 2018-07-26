import Vapor

/// The outcome of an adjudication.
public enum AdjudicationOutcome: String, Hashable, CaseIterable, Content {
    
    /// This will resolve the case in buyer favor and outcome will be set as RESOLVED_BUYER_FAVOR
    case buyer = "BUYER_FAVOR"
    
    /// This will resolve the case in seller favor and outcome will be set as RESOLVED_SELLER_FAVOR
    case seller = "SELLER_FAVOR"
}
