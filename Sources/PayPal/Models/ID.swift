import Vapor

/// A container for a nested ID in an object.
public struct ID: Content, Equatable, ExpressibleByStringLiteral {
    
    /// The nested ID in the parent object.
    public let id: String?
    
    /// Creates a new `ID` instance.
    ///
    ///     ID("P-52603F876DFD4C61")
    public init(_ id: String? = nil) {
        self.id = id
    }
    
    /// Creates a new `ID` instance from a `String` literal.
    ///
    ///     let id: ID = "P-52603F876DFD4C61"
    public init(stringLiteral value: String) {
        self.id = value
    }
}
