import Vapor

/// A patch operation made on an API resource element.
public struct Patch<Value>: Content, Equatable where Value: Codable & Equatable {
    
    /// The operation to complete.
    public var operation: Operation
    
    /// The JSON pointer to the target document location at which to complete the operation.
    public var path: String?
    
    /// The value to apply. The `remove` operation does not require a value.
    public var value: Value?
    
    /// The JSON pointer to the target document location from which to move the value. Required for the `move` operation.
    public var from: String?
    
    /// Creates a new `Patch` instance.
    ///
    ///     Patch(
    ///         operation: .move,
    ///         path: "/age",
    ///         value: 21,
    ///         from: "/current_age"
    ///     )
    public init(operation: Operation, path: String?, value: Value?, from: String? = nil) {
        self.operation = operation
        self.path = path
        self.value = value
        self.from = from
    }
}
