import Vapor

/// Partner-specific options for an account.
public struct PartnerOptions: Content, Equatable {
    
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
}
