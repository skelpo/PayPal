import Vapor

/// Additional information for a money request transaction.
public final class RequestMoneyProperties: Content {
    
    /// The role of the user in the money request transaction.
    public var role: Role?
    
    /// Creates a new `RequestMoneyProperties` instance.
    public init(role: Role?) {
        self.role = role
    }
}
