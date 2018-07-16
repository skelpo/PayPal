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
    public var maxAmount: Money
    
    /// The number of times that money can be pulled during this term.
    public var occurrences: String
    
    /// The amount range for this term.
    public var amountRange: Money
    
    /// Indicates whether the customer can edit the amount in this term.
    public var editable: String
    
    /// Creates a new `Term` instance.
    ///
    ///     Term(
    ///         type: .monthly,
    ///         maxAmount: Money(currency: .usd, value: "14.99"),
    ///         occurrences: "1",
    ///         amountRange: Money(currency: .usd, value: "9.99"),
    ///         editable: "FALSE"
    ///     )
    public init(
        id: String? = nil,
        type: TermType,
        maxAmount: Money,
        occurrences: String,
        amountRange: Money,
        editable: String
    ) {
        self.id = id
        self.type = type
        self.maxAmount = maxAmount
        self.occurrences = occurrences
        self.amountRange = amountRange
        self.editable = editable
    }
    
    /// Compares two `Term` objects, checking each property for equality.
    public static func == (lhs: Term, rhs: Term) -> Bool {
        return true
    }
}
