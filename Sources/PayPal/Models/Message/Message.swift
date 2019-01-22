import Vapor

/// A communication between a customer and merchant of a transaction.
public struct Message: Content, Equatable {
    
    /// Indicates whether the customer or merchant posted the message.
    public let poster: Poster?
    
    /// The date and time when the message was posted, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let posted: ISO8601Date?
    
    /// The message text.
    ///
    /// Minimum length: 0. Maximum length: 2000.
    public var content: Failable<String, Length2000>
    
    /// Creates a new `Message` instance.
    ///
    /// - Parameter content: The message text.
    public init(content: Failable<String, Length2000>) {
        self.poster = nil
        self.posted = nil
        self.content = content
    }
    
    enum CodingKeys: String, CodingKey {
        case poster = "posted_by"
        case posted = "time_posted"
        case content
    }
}
