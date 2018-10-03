import Vapor

/// An error that occured in the PayPal package.
public struct PayPalError: AbortError {
    
    /// The error's identifier. Similar to the case name when using enums for error handling.
    public var identifier: String
    
    /// A human readable reason for the error.
    public var reason: String
    
    /// An HTTP status code for the error, for if it get converted to a response.
    public var status: HTTPResponseStatus
    
    /// Creates a new `PayPalError`.
    ///
    /// - Parameters:
    ///   - status: The HTTP status code for the error. This defaults to 500 (Internal Server Error)
    ///   - identifier: An identifier for the error
    ///   - reason: A human readable representation of the error. This defaults to an empty string.
    public init(status: HTTPStatus = .internalServerError, identifier: String, reason: String = "") {
        self.identifier = identifier
        self.reason = reason
        self.status = status
    }
}
