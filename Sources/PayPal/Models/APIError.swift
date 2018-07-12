import Vapor

/// Represents a standard error response returned by a PayPal API endpoint.
public struct PayPalAPIError: Error, AbortError, Content, Equatable {
    
    /// The HTTP status that will used if a `PayPalAPIError` is
    /// returned or thrown from a service route.
    /// This status is always [424 (Failed Dependency)](https://tools.ietf.org/html/rfc2518#section-10.5).
    public let status: HTTPResponseStatus = .failedDependency
    
    /// A human readable message that describes the error.
    /// The `CodingKey` string value for this property is `message`
    public var reason: String
    
    /// A machine readable string that ideentifies the error.
    /// The `CodingKey` string value for this property is `name`.
    public var identifier: String
    
    /// A link to the error's documentation.
    public var informationLink: String?
    
    /// Creates a new `PayPalAPIError` instance.
    ///
    ///     PayPalAPIError(
    ///         identifier: "PERMISSION_DENIED",
    ///         message: "No permission for the requested operation"
    ///         informationLink: nil
    ///     )
    public init(identifier: String, reason: String, informationLink: String?) {
        self.identifier = identifier
        self.reason = reason
        self.informationLink = informationLink
    }
    
    
    /// An array of string URLs linking to documentation pertaining to the error.
    ///
    /// The value return is `PayPalAPIError.details` wrapped in an array.
    public var documentationLinks: [String] {
        return self.informationLink == nil ? [] : [self.informationLink!]
    }
    
    enum CodingKeys: String, CodingKey {
        case reason = "message"
        case identifier = "name"
        case informationLink = "information_link"
    }
}

/// Represents an Identity error response returned by a PayPal API endpoint.
public struct PayPalAPIIdentityError: Error, AbortError, Content {
    
    /// The HTTP status that will used if a `PayPalAPIIdentityError` is
    /// returned or thrown from a service route.
    /// This status is always [424 (Failed Dependency)](https://tools.ietf.org/html/rfc2518#section-10.5).
    public let status: HTTPResponseStatus = .failedDependency
    
    /// A human readable message that describes the error.
    /// The `CodingKey` string value for this property is `error_description`
    public var reason: String
    
    /// A machine readable string that identifies the error.
    /// The `CodingKey` string value for this property is `error`.
    public var identifier: String
    
    /// Creates a new `PayPalAPIIdentityError` instance.
    ///
    ///     PayPalAPIIdentityError(identifier: "invalid_client", reason: "Client Authentication failed")
    public init(identifier: String, reason: String) {
        self.reason = reason
        self.identifier = identifier
    }
    
    enum CodingKeys: String, CodingKey {
        case reason = "error"
        case identifier = "error_description"
    }
}
