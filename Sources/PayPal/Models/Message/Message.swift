import Vapor

/// A communication between a customer and merchant of a transaction.
public struct Message: Content, Equatable {
    
    /// Indicates whether the customer or merchant posted the message.
    public let poster: Poster?
    
    /// The date and time when the message was posted, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let posted: String?
    
    /// The message text.
    ///
    /// Minimum length: 0. Maximum length: 2000.
    public var content: String
    
    /// Creates a new `Message` instance.
    ///
    ///     Message(content: "You might be a developer if you see a music album called J. S. Bach and wonder why it is not called Back.js")
    public init(content: String) {
        self.poster = nil
        self.posted = nil
        self.content = content
    }
}
