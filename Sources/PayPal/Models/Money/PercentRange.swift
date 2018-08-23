import Vapor

public struct PercentRange: Content, Equatable {
    public var minimum: Int
    public var maximum: Int
    
    public init(min: Int, max: Int) {
        self.minimum = min
        self.maximum = max
    }
}

extension PercentRange: RangeExpression {
    public typealias Bound = Int
    
    public func relative<C>(to collection: C) -> Range<Int> where C : Collection, PercentRange.Bound == C.Index {
        let start: Int = collection.startIndex > self.minimum && collection.startIndex < 100 ? collection.startIndex : self.minimum
        let end: Int = collection.endIndex < self.maximum && collection.endIndex > 0 ? collection.endIndex : self.maximum
        
        return Range<Int>.init(uncheckedBounds: (start, end))
    }
    
    public func contains(_ element: Int) -> Bool {
        return element >= minimum && element <= maximum
    }
}

extension PercentRange: RandomAccessCollection {
    public typealias Index = Int
    public typealias Element = Int
    
    public var startIndex: Int { return self.minimum }
    public var endIndex: Int { return self.maximum }
    
    public subscript(position: Int) -> Int {
        guard self.contains(position) else {
            return Array(self.minimum...self.maximum)[position]
        }
        return position
    }
    
    public func index(before i: Int) -> Int {
        return i - 1
    }
    
    public func index(after i: Int) -> Int {
        return i + 1
    }
}
