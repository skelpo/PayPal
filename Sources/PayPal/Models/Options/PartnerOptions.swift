import Vapor

/// Partner-specific options for an account.
public struct PartnerOptions: Content, Equatable, ExpressibleByDictionaryLiteral {
    
    /// An array of key-and-value pairs that contain custom partner information.
    public var fields: [KeyValue]?
    
    /// Creates a new `PartnerOptions` instance.
    ///
    ///     PartnerOption(fields: ["key": "value"])
    ///
    /// - Parameter fields: An array of key-and-value pairs that contain custom partner information.
    public init(fields: [KeyValue]?) {
        self.fields = fields
    }
    
    /// See `ExpressibleByDictionaryLiteral.init(dictionaryLiteral:)`.
    public init(dictionaryLiteral elements: (String, String)...) {
        self.fields = elements.map(KeyValue.init)
    }
    
    /// Gets the first value with a matching key.
    ///
    /// - Parameter key: The key of the value to find.
    ///
    /// - Returns: The value for the key passed in if one exists, otherwise `nil`.
    public subscript(key: String) -> String? {
        get {
            return self.fields?[key] ?? nil
        }
        set {
            self.fields?[key] = newValue
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case fields = "partner_fields"
    }
}
