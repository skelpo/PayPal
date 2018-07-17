// MARK: - Operators

infix operator <~

/// Creates a `ValidationSetable` setter from a key-path and value.
///
/// This operator is simply for syntax suger.
///
///     object.set(\.foo <~ "Hello World")
public func <~<Root, Value>(path: WritableKeyPath<Root, Value>, value: Value)throws -> Setter<Root, Value> {
    return Setter(key: path, value: value)
}

// MARK: - Errors

/// An error that occurs when validating a new value for
/// the `ValidationSetable.set(_:)` method.
public enum SetterValidationError: Error {
    
    /// Unable to convert the new value from `Any` to `Value` (a generic type).
    ///
    /// This error should never be reached, as the type is converted from `Value`
    /// to `Any` to `Value` without ever being accessible during the process.
    case unknownProperty
}

// MARK: - Setters

/// A container for the property to be set and the new value to set it to.
public struct Setter<Root, Value> {
    
    /// The key-path for the property that the new
    /// value will be set to.
    public let key: WritableKeyPath<Root, Value>
    
    /// The value to validate and set the property to.
    public let value: Value
}

// MARK: - Validations

/// A container for a type's property value validations.
public struct SetterValidations<Root> {
    internal var validations: [PartialKeyPath<Root>: (Any)throws -> ()]
    
    /// Creates a new `SetterValidations` instance with a specified root type.
    ///
    ///     SetterValidations(User.self)
    public init(_ rootType: Root.Type = Root.self) {
        self.validations = [:]
    }
    
    /// The the validation for a property of the `Root` type.
    ///
    /// - Parameters:
    ///   - path: The key-path for the property that the validation is for.
    ///   - closure: The function that validates the new value before it assigned
    ///     to the property.
    public mutating func set<Value>(_ path: WritableKeyPath<Root, Value>, to closure: @escaping (Value)throws -> ()) {
        let wrapper = { (input: Any)throws -> () in
            guard let value = input as? Value else { throw SetterValidationError.unknownProperty }
            try closure(value)
        }
        self.validations[path] = wrapper
    }
}

// MARK: - ValidationSetable Protocol

/// A type who's properties can be set with a validated value.
public protocol ValidationSetable {
    
    /// A constructor for the type's proeprty's validations.
    ///
    /// - Returns: A container holding the validations.
    static func setterValidations() -> SetterValidations<Self>
    
    /// Sets one of the type's properties if the new value passes validation.
    ///
    ///     try object.set(\.foo <~ "Hello World")
    ///
    /// - Parameter setter: The key-path of the property to set
    ///   and the value to set the property to.
    ///
    /// - Throws: Any errors that occur while validating the new value.
    mutating func set<Value>(_ setter: Setter<Self, Value>)throws
}

extension ValidationSetable {
    public mutating func set<Value>(_ setter: Setter<Self, Value>)throws {
        try Self.setterValidations().validations[setter.key]?(setter.value)
        self[keyPath: setter.key] = setter.value
    }
    
    /// Sets one of the type's properties to a new value if it passes validation.
    ///
    ///     try object.set(\.foo, to: "Hello World")
    ///
    /// - Parameters:
    ///   - path: The key-path of the property to set.
    ///   - value: The new value to validate and set the property to.
    ///
    /// - Throws: Any errors that occur when validating the new value.
    public mutating func set<Value>(_ path: WritableKeyPath<Self, Value>, to value: Value)throws {
        try self.set(Setter(key: path, value: value))
    }
}
