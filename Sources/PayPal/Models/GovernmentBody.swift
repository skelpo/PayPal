import Vapor

/// [PayPal API docs](https://developer.paypal.com/docs/api/managed-accounts/v1/#definition-government_body).
public struct GovernmentBody: Content, Equatable {
    
    /// The name of enabling legislation.
    public var name: String?
    
    /// Creates a new `GovernmentBody` instance.
    ///
    /// - parameter name: The name of enabling legislation.
    public init(name: String?) {
        self.name = name
    }
}
