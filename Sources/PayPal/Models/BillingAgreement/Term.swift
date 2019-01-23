import Vapor

/// A term for a billing agreement plan.
public final class Term: Content, Equatable {
    
    /// The PayPal-generated ID for the resource.
    ///
    /// Maximum length: 128.
    public let id: String?
    
    /// The term type.
    public var type: TermType
    
    /// The currency and amount of the maximum billing amount associated with this term.
    public var maxAmount: CurrencyCodeAmount
    
    /// The number of times that money can be pulled during this term.
    public var occurrences: String
    
    /// The amount range for this term.
    public var amountRange: CurrencyCodeAmount
    
    /// Indicates whether the customer can edit the amount in this term.
    public var editable: String
    
    /// Creates a new `Term` instance.
    ///
    /// - Parameters:
    ///   - type: The term type.
    ///   - maxAmount: The currency and amount of the maximum billing amount associated with this term.
    ///   - occurrences: The number of times that money can be pulled during this term.
    ///   - amountRange: The amount range for this term.
    ///   - editable: Indicates whether the customer can edit the amount in this term.
    public init(
        type: TermType,
        maxAmount: CurrencyCodeAmount,
        occurrences: String,
        amountRange: CurrencyCodeAmount,
        editable: String
    )throws {
        self.id = nil
        self.type = type
        self.maxAmount = maxAmount
        self.occurrences = occurrences
        self.amountRange = amountRange
        self.editable = editable
    }
    
    /// Compares two `Term` objects, checking each property for equality.
    public static func == (lhs: Term, rhs: Term) -> Bool {
        return
            (lhs.id == rhs.id) &&
            (lhs.type == rhs.type) &&
            (lhs.maxAmount == rhs.maxAmount) &&
            (lhs.occurrences == rhs.occurrences) &&
            (lhs.amountRange == rhs.amountRange) &&
            (lhs.editable == rhs.editable)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, type, occurrences
        case maxAmount = "max_billing_amount"
        case amountRange = "amount_range"
        case editable = "buyer_editable"
    }
}
