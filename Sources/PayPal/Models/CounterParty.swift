import Vapor

/// The opposite party in a transaction.
public final class CounterParty: Content, Equatable {
    
    /// The other party's email address. For unregistered users only.
    public var email: String?
    
    /// The other party's mobile phone number.
    public var phoneNumber: String?
    
    /// The other party's name, which is usually the first and last name or the merchant's store name
    public var name: String?
    
    /// Create a new `CounterPart` instance.
    ///
    ///     CounterParty(email: "once.again@exmaple.com", phoneNumber: "314-159-2653", name: "Hallidy")
    public init(email: String?, phoneNumber: String?, name: String?) {
        self.email = email
        self.phoneNumber = phoneNumber
        self.name = name
    }
    
    /// Compares two `CounterParty` objects, checking that the `email`, `phoneNumber`, and `name` properties are equal.
    public static func == (lhs: CounterParty, rhs: CounterParty) -> Bool {
        return (lhs.email == rhs.email) && (lhs.phoneNumber == rhs.phoneNumber) && (lhs.name == rhs.name)
    }
    
    enum CodingKeys: String, CodingKey {
        case email, name
        case phoneNumber = "phone_number"
    }
}
