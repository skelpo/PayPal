import Vapor

/// The action taken if the customer's initial payment in a billing agreement fails.
public enum InitialFailAction: String, Hashable, CaseIterable, Content {
    
    /// The agreement remains active and the failed payment amount is added
    /// to the outstanding balance. If auto-billing is enabled, PayPal
    /// automatically bills the outstanding balance in the next billing cycle.
    ///
    /// This is the default value picked by the PayPal API.
    case `continue` = "CONTINUE"
    
    /// PayPal creates the agreement but sets its state to pending until the initial
    /// payment clears. When the initial payment clears, the pending agreement becomes active.
    /// If the initial payment fails, the pending agreement is cancelled.
    case cancel = "CANCEL"
}
