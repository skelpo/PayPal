import Vapor

/// An array of financial instruments, keyed with a `CodingKey` with the value `financial_instruments`.
public struct FinancialInstruments: Content, Equatable {
    
    /// An array of financial instruments.
    public var instruments: [FinancialInstrument]?
    
    /// Creates a new `FinancialInstruments` instance.
    ///
    /// - Parameter instruments: An array of financial instruments.
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
    /// - Parameter accountType: The bank account type. Defaults to `.checking`.
    public init(accountType: AccountType = .checking) {
        self.type = .bank
        self.id = nil
        self.accountType = accountType
    }
    
    enum CodingKeys: String, CodingKey {
        case type, id
        case accountType = "account_type"
    }
}
