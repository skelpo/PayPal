import Vapor

/// The customer service information for a business or organization.
public struct CustomerService: Content, Equatable {
    
    /// The business's customer service email address, in [Simple Mail Transfer Protocol](https://www.ietf.org/rfc/rfc5321.txt) as defined in RFC 5321
    /// or in [Internet Message Format](https://www.ietf.org/rfc/rfc5322.txt) as defined in RFC 5322. Does not support Unicode email addresses.
    public var email: EmailAddress
    
    /// The customer service phone number for the business.
    public var phone: PhoneNumber?
    
    /// An array of customer service messages.
    public var message: [Message]?
    
    
    /// Creates a new `CustomerService` instance.
    ///
    ///     CustomerService(email: EmailAddress(email: "address@email.com"), phone: PhoneNumber(country: "1", number: "9963191901"), message: [])
    public init(email: EmailAddress, phone: PhoneNumber?, message: [Message]?) {
        self.email = email
        self.phone = phone
        self.message = message
    }
}
