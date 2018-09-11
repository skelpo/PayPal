import Vapor

/// Partner-specific options for an account.
public struct PartnerOptions: Content, Equatable, ExpressibleByDictionaryLiteral {
    
    /// An array of key-and-value pairs that contain custom partner information.
    public var fields: [KeyValue]
    
    /// Creates a new `PartnerOptions` instance.
    ///
    ///     PartnerOption(fields: ["key": "value"])
    ///
    /// - Parameter fields: An array of key-and-value pairs that contain custom partner information.
    public init(fields: [KeyValue]) {
        self.fields = fields
    }
    
    /// See `ExpressibleByDictionaryLiteral.init(dictionaryLiteral:)`.
    public init(dictionaryLiteral elements: (String, String)...) {
        self.fields = elements.map(KeyValue.init)
    }
    
    enum CodingKeys: String, CodingKey {
        case fields = "partner_fields"
    }
}
