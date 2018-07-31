import Core

extension Future where T: Collection {
    
    /// Gets the element from a collection wrapped by a future at a given index.
    ///
    /// - Parameter index: The index of the element to get.
    ///
    /// - Returns: The element that was found at the index passed in, wrapped in a future.
    public subscript(_ index: T.Index) -> Future<T.Element?> {
        return self.map(to: T.Element?.self) { this in return this[index] }
    }
}

extension Future {
    
    /// Gets the value from a dictionary wrapped in a future.
    ///
    /// - Parameter key: The key of the value in the dictionary to fetch.
    ///
    /// - Returns: The value of the key passed in, wrapped in a future.
    public subscript<Key, Value>(_ key: Key) -> Future<Value?> where T == Dictionary<Key, Value> {
        return self.map(to: Value?.self) { this in return this[key] }
    }
    
    /// Gets the value from a dictionary wrapped in a future. If no value is found, the default value is used.
    ///
    /// - Parameters:
    ///   - key: The key of the value in the dictionary to fetch.
    ///   - default: The value to return if none is found for the key passed in.
    ///
    /// - Returns: The value of the key passed in or the default value, wrapped in a future.
    public subscript<Key, Value>(_ key: Key, `default`: Value) -> Future<Value> where T == Dictionary<Key, Value> {
        return self.map(to: Value.self) { this in return this[key, default: `default`] }
    }
}
