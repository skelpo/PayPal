import Vapor

/// A key/value type wrapper for array helpers.
public protocol DictionaryElement: Content, Equatable {
    associatedtype Key: Hashable
    associatedtype Value: Equatable
    
    var key: Key { get }
    var value: Value { get set }
    
    init(key: Key, value: Value)
}

/// A `name/value` combination, like a dictionary element.
public struct NameValue: DictionaryElement {

    /// A key. For example aa_token.
    public var name: String
    
    /// The value of the key.
    public var value: String
    
    
    /// Creates a new `KeyValue` instance.
    ///
    /// - Parameters:
    ///   - name: The name for the value.
    ///   - value: The value that can be accessed with the given key.
    public init(key: String, value: String) {
        self.name = key
        self.value = value
    }
    
    public var key: String { return self.name }
}

/// A `key/value` combination, like a dictionary element.
public struct KeyValue: DictionaryElement, ExpressibleByDictionaryLiteral {
    
    /// A key. For example aa_token.
    public var key: String?
    
    /// The value of the key.
    public var value: String?
    
    
    /// Creates a new `KeyValue` instance.
    ///
    /// - Parameters:
    ///   - key: The key for the value.
    ///   - value: The value that can be accessed with the given key.
    public init(key: String?, value: String?) {
        self.key = key
        self.value = value
    }
    
    /// See `ExpressibleByDictionaryLiteral.init(dictionaryLiteral:)`.
    public init(dictionaryLiteral elements: (String?, String?)...) {
        self = elements.first.map(KeyValue.init) ?? KeyValue(key: nil, value: nil)
    }
}

extension Array: ExpressibleByDictionaryLiteral where Element: DictionaryElement {
    
    /// See `ExpressibleByDictionaryLiteral.Key`.
    public typealias Key = Element.Key
    
    /// See `ExpressibleByDictionaryLiteral.Value`.
    public typealias Value = Element.Value
    
    /// See `ExpressibleByDictionaryLiteral.init(dictionaryLiteral:)`.
    public init(dictionaryLiteral elements: (Key, Value)...) {
        self = elements.map(Element.init)
    }
    
    /// Gets the first value with a matching key.
    ///
    /// - Parameter key: The key of the value to find.
    ///
    /// - Returns: The value for the key passed in if one exists, otherwise `nil`.
    public subscript(key: Key) -> Value? {
        get {
            return self.first { $0.key == key }?.value
        }
        set {
            guard let index = self.firstIndex(where: { $0.key == key }) else { return }
            if let value = newValue {
                self[index].value = value
            }
        }
    }
}
