import Vapor

/// A communication between a customer and merchant of a transaction.
public struct Message: Content, ValidationSetable, Equatable {
    
    /// Indicates whether the customer or merchant posted the message.
    public let poster: Poster?
    
    /// The date and time when the message was posted, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let posted: String?
    
    /// The message text.
    ///
    /// To set this property, use the `Message.set(_:)` method. This will
    /// validate the new value before assigning it to the property.
    ///
    /// Minimum length: 0. Maximum length: 2000.
    public private(set) var content: String
    
    /// Creates a new `Message` instance.
    ///
    ///     Message(content: "You might be a developer if you see a music album called J. S. Bach and wonder why it is not called Back.js")
    public init(content: String) {
        self.poster = nil
        self.posted = nil
        self.content = content
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<Message> {
        var validations = SetterValidations(Message.self)
        
        validations.set(\.content) { content in
            guard content.count <= 2000 else {
                throw PayPalError(identifier: "invalidLength", reason: "`content` property must have a length between 0 and 2000")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case poster = "posted_by"
        case posted = "time_posted"
        case content
    }
}
