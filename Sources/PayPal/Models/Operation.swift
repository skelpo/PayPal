import Vapor

/// An operation that can be made on an API resource element.
public enum Operation: String, Hashable, CaseIterable, Content {
    
    /// Add a value to the element.
    case add
    
    /// Remove a value from the element.
    case remove
    
    /// Replace a value in the element with a new value.
    case replace
    
    /// Move the value in an element to a new JSON path.
    case move
    
    ///
    case copy
    
    ///
    case test
}
