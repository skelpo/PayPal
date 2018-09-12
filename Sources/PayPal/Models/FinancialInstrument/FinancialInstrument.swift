import Vapor

public struct FinancialInstruments: Content, Equatable {
    public var instruments: [FinancialInstrument]?
    
    public init(instruments: [FinancialInstrument]?) {
        self.instruments = instruments
    }
    
    enum CodingKeys: String, CodingKey {
        case instruments = "financial_instruments"
    }
}

/// A financial instrument that can be used to make and receive payments (or something like that, Paypal doesn't say).
public struct FinancialInstrument: Content, Equatable {
    
    /// The financial instrument type. Currently supports `BANK` only.
    public var type: InstrumentType?
    
    /// The bank account type.
    public var accountType: AccountType
    
    /// The PayPal-generated financial instrument ID.
    public var id: String?
    
    
    /// Creates a new `FinancialInstrument` instance.
    ///
    /// - Parameters:
    ///   - id: The PayPal-generated financial instrument ID. Defaults to `nil`.
    ///   - accountType: The bank account type. Defaults to `.checking`.
    public init(id: String? = nil, accountType: AccountType = .checking) {
        self.type = .bank
        self.id = id
        self.accountType = accountType
    }
    
    enum CodingKeys: String, CodingKey {
        case type, id
        case accountType = "account_type"
    }
}
