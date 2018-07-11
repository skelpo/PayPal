import Vapor

/// Represents an error response returned by a PayPal API endpoint.
public final class PayPalAPIError: Error, AbortError, Content {
    
    /// The HTTP status that will used if a `PayPalAPIError` is
    /// returned or thrown from a service route.
    /// This status is always [424 (Failed Dependency)](https://tools.ietf.org/html/rfc2518#section-10.5).
    public let status: HTTPResponseStatus = .failedDependency
    
    /// A human readable message that describes the error.
    /// The `CodingKey` string value for this property is `error_description`
    public var reason: String
    
    /// A machine readable string that ideentifies the error.
    /// The `CodingKey` string value for this property is `error`.
    public var identifier: String
    
    /// Creates a new `PayPalAPIError` instance.
    ///
    ///     PayPalAPIError(identifier: "invalid_client", reason: "Client Authentication failed")
    public init(identifier: String, reason: String) {
        self.reason = reason
        self.identifier = identifier
    }
    
    enum CodingKeys: String, CodingKey {
        case reason = "error"
        case identifier = "error_description"
    }
}
