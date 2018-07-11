import Vapor

/// Additional information for an order activity.
public typealias OrderProperties = RoleObjectProperties

/// Additional information for a money request activity
public typealias MoneyRequestProperties = RoleObjectProperties

/// Additional information for an object in transaction that only has a `role`.
public final class RoleObjectProperties: Content, Equatable {
    
    /// The role of the user in the transaction.
    public var role: Role?
    
    /// Creates a new `RoleObjectProperties` instance.
    public init(role: Role?) {
        self.role = role
    }
    
    /// Compares two `RoleObjectProperties` objects, checking that the `role` properties are the same
    public static func == (lhs: RoleObjectProperties, rhs: RoleObjectProperties) -> Bool {
        return lhs.role == rhs.role
    }
}
