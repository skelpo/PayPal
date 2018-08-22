import Vapor

public struct CustomerService: Content, Equatable {
    public var email: EmailAddress
    public var phone: PhoneNumber?
    public var message: [Message]?
    
    public init(email: EmailAddress, phone: PhoneNumber?, message: [Message]?) {
        self.email = email
        self.phone = phone
        self.message = message
    }
}
