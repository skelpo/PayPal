import Vapor

/// A financial instrument that can be used to make and receive payments (or something like that, Paypal doesn't say).
public struct FinancialInstrument: Content, Equatable {
    
    /// The financial instrument type. Currently supports `BANK` only.
    public let type: InstrumentType?
    
    /// The bank account type.
    public let accountType: String
    
    /// The PayPal-generated financial instrument ID.
    public var id: String?
    
    
    /// Creates a new `FinancialInstrument` instance.
    ///
    /// - Parameter id: The PayPal-generated financial instrument ID. Defaults to `nil`.
    public init(id: String? = nil) {
        self.type = .bank
        self.id = id
        self.accountType = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case type, id
        case accountType = "account_type"
    }
}
