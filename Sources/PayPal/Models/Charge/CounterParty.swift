import Vapor

/// The opposite party in a transaction.
public struct CounterParty: Content, Equatable {
    
    /// The other party's email address. For unregistered users only.
    public var email: String?
    
    /// The other party's mobile phone number.
    public var phoneNumber: String?
    
    /// The first name of the counter party.
    public var firstName: String?
    
    /// The last name of the counter part.
    public var lastName: String?
    
    /// The other party's name, which is usually the first and last name or the merchant's store name.
    public var name: String?
    
    /// The ID of the payment that the counter-party's activity is connected to.
    public var payment: String?
    
    /// Create a new `CounterParty` instance.
    ///
    /// - Parameters:
    ///   - email: The other party's email address. For unregistered users only.
    ///   - phoneNumber: The other party's mobile phone number.
    ///   - firstName: The first name of the counter party.
    ///   - lastName: The last name of the counter part.
    ///   - name: The other party's name, which is usually the first and last name or the merchant's store name.
    ///   - payment: The ID of the payment that the counter-party's activity is connected to.
    public init(email: String?, phoneNumber: String?, firstName: String?, lastName: String?, name: String?, payment: String?) {
        self.email = email
        self.phoneNumber = phoneNumber
        self.firstName = firstName
        self.lastName = lastName
        self.name = name
        self.payment = payment
    }
    
    enum CodingKeys: String, CodingKey {
        case email, name
        case phoneNumber = "phone_number"
        case firstName = "first_name"
        case lastName = "last_name"
        case payment = "payment_id"
    }
}
