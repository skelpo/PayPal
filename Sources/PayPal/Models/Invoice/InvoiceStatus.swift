import Vapor

extension Invoice {
    public enum Status: String, Hashable, CaseIterable, Content {
        case draft = "DRAFT"
        case unpaid = "UNPAID"
        case sent = "SENT"
        case scheduled = "SCHEDULED"
        case partiallyPaid = "PARTIALLY_PAID"
        case pending = "PAYMENT_PENDING"
        case paid = "PAID"
        case markedPaid = "MARKED_AS_PAID"
        case cancelled = "CANCELLED"
        case refunded = "REFUNDED"
        case partiallyRefunded = "PARTIALLY_REFUNDED"
        case markedRefunded = "MARKED_AS_REFUNDED"
    }
}
