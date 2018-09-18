import Vapor

public struct Capture {}

extension Capture {
    public enum Status: String, Hashable, CaseIterable, Content {
        
        /// The purchase unit status is `CAPTURED` and the capture status is pending.
        case pending = "PENDING"
        
        /// The purchase unit status is `CAPTURED` and the payment was captured successfully.
        case complete = "COMPLETE"
        
        /// The purchase unit status is `CAPTURED` and the dispute decision was in the customer's favor.
        /// A full refund for the captured payment was made successfully to the customer.
        case refunded = "REFUNDED"
        
        /// The purchase unit status is `CAPTURED` and the dispute decision was in the customer's favor.
        /// A partial refund for the captured payment was made successfully to the customer.
        case partiallyRefunded = "PARTIALLY_REFUNDED"
        
        /// The purchase unit status is `CAPTURED` and the capture was denied.
        case denied = "DENIED"
    }
}
