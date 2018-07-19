import Vapor
import JSON

/// A patch operation made on an API resource element.
public struct Patch: Content, Equatable {
    
    /// The operation to complete.
    public var operation: Operation
    
    /// The JSON pointer to the target document location at which to complete the operation.
    public var path: String?
    
    /// The value to apply. The `remove` operation does not require a value.
    public var value: JSON?
    
    /// The JSON pointer to the target document location from which to move the value. Required for the `move` operation.
    public var from: String?
    
    /// Creates a new `Patch` instance.
    ///
    ///     Patch(
    ///         operation: .move,
    ///         path: "/age",
    ///         value: .number(.int(21)),
    ///         from: "/current_age"
    ///     )
    public init(operation: Operation, path: String?, value: JSON?, from: String? = nil) {
        self.operation = operation
        self.path = path
        self.value = value
        self.from = from
    }
    
    /// Creates a new `Patch` instance.
    ///
    ///     try Patch(
    ///         operation: .move,
    ///         path: "/age",
    ///         value: 21,
    ///         from: "/current_age"
    ///     )
    public init(operation: Operation, path: String?, value: FailableJSONRepresentable?, from: String? = nil)throws {
        self.operation = operation
        self.path = path
        self.value = try value?.failableJSON()
        self.from = from
    }
    
    enum CodingKeys: String, CodingKey {
        case path, value, from
        case operation = "op"
    }
}
