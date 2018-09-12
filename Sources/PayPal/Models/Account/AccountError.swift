import Vapor

/// An error that can occur when you add bundles to a customer account.
public struct AccountError: Content, Error, Equatable {
    
    /// The information link, or URI, that shows detailed information about this error for the developer.
    public let information: String?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    
    /// The human-readable, unique name of the error.
    public var name: String
    
    /// The message that describes the error.
    public var message: String
    
    /// The PayPal internal ID that is used for correlation purposes.
    public var debug: String
    
    /// An array of additional details about the error.
    public var details: [Details]?
    
    
    /// Creates a new `AccountError` instance.
    ///
    /// - Parameters:
    ///   - name: The human-readable, unique name of the error.
    ///   - message: The message that describes the error.
    ///   - debug: The PayPal internal ID that is used for correlation purposes.
    ///   - details: An array of additional details about the error.
    public init(name: String, message: String, debug: String, details: [Details]?) {
        self.information = nil
        self.links = nil
        
        self.name = name
        self.message = message
        self.debug = debug
        self.details = details
    }
}
