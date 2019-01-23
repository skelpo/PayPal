import Vapor

/// Validation used for the `PercentRange.max` property.
public struct PercentMax: InRangeValidation {
    
    /// See `Validations.Supported`.
    public typealias Supported = Int
    
    /// The `PercentRange.max` property must be `100` or less.
    public static var max: Int? = 100
    
    /// The `PercentRange.max` property must be `1` or more.
    public static var min: Int? = 1
}

/// Validation used for the `PercentRange.min` property.
public struct PercentMin: InRangeValidation {
    
    /// See `Validations.Supported`.
    public typealias Supported = Int
    
    /// The `PercentRange.min` property must be `99` or less.
    public static var max: Int? = 99
    
    /// The `PercentRange.min` property must be `0` or more.
    public static var min: Int? = 0
}

/// A range of percentages, including all whole numbers between a spoecified minimum and maximum values.
public struct PercentRange: Content, Hashable {
    
    /// The minimum inclusive value of the range.
    ///
    /// Minimum value: 0. Maximum value: 99.
    public var minimum: Failable<Int, PercentMin>
    
    /// The maximum inclusive value of the range.
    ///
    /// Minimum value: 1. Maximum value: 100.
    public var maximum: Failable<Int, PercentMax>
    
    
    /// Creates a new `PercentRange` instance.
    ///
    ///     PercentRange(min: 25, max: 75)
    public init(min: Failable<Int, PercentMin>, max: Failable<Int, PercentMax>) {
        self.minimum = min
        self.maximum = max
    }
    
    /// Creates a new `PercentRange` instance with a closed range.
    ///
    ///     PercentRange(50..<100)
    public init(_ range: Range<Int>)throws {
        self.minimum = try range.lowerBound.failable()
        self.maximum = try (range.last ?? range.upperBound).failable()
    }
    
    /// Creates a new `PercentRange` instance with a closed range.
    ///
    ///     PercentRange(50...75)
    public init(_ range: ClosedRange<Int>)throws {
        self.minimum = try range.lowerBound.failable()
        self.maximum = try range.upperBound.failable()
    }
    
    /// Creates a new `PercentRange` instance with a closed range.
    ///
    ///     PercentRange(50...)
    ///
    /// - Note: `maximum` property gets assigned `100`.
    public init(_ range: PartialRangeFrom<Int>)throws {
        self.minimum = try range.lowerBound.failable()
        self.maximum = 100
    }
    
    
    /// Creates a new `PercentRange` instance with a closed range.
    ///
    ///     PercentRange(...100)
    ///
    /// - Note: `minimum` property gets assigned `0`.
    public init(_ range: PartialRangeThrough<Int>)throws {
        self.minimum = 0
        self.maximum = try range.upperBound.failable()
    }
    
    /// Creates a new `PercentRange` instance with a closed range.
    ///
    ///     PercentRange(..<100)
    ///
    /// - Note: `minimum` property gets assigned `0`.
    public init(_ range: PartialRangeUpTo<Int>)throws {
        self.minimum = 0
        self.maximum = try (range.upperBound - 1).failable()
    }
    
    enum CodingKeys: String, CodingKey {
        case minimum = "minimum_percent"
        case maximum = "maximum_percent"
    }
}

extension PercentRange: RangeExpression {
    
    /// See [`RangeExpression.Bound`](https://developer.apple.com/documentation/swift/rangeexpression/2894257-bound).
    public typealias Bound = Int
    
    /// See [`RangeExpression.relative(to:)`](https://developer.apple.com/documentation/swift/rangeexpression/2944184-relative).
    public func relative<C>(to collection: C) -> Range<Int> where C : Collection, PercentRange.Bound == C.Index {
        let start = (collection.startIndex > self.minimum.value && collection.startIndex < 100) ? collection.startIndex : self.minimum.value
        let end = (collection.endIndex < self.maximum.value && collection.endIndex > 0) ? collection.endIndex : self.maximum.value
        
        return Range<Int>.init(uncheckedBounds: (start, end))
    }
    
    /// See [`RangeExpression.contains(_:)`](https://developer.apple.com/documentation/swift/rangeexpression/2893202-contains)
    public func contains(_ element: Int) -> Bool {
        return element >= self.minimum.value && element <= self.maximum.value
    }
}

extension PercentRange: RandomAccessCollection {
    
    /// See [`RandomAccessCollection.Index`](https://developer.apple.com/documentation/swift/randomaccesscollection/2946102-index).
    public typealias Index = Int
    
    /// See [`RandomAccessCollection.Element`](https://developer.apple.com/documentation/swift/randomaccesscollection/2945146-element).
    public typealias Element = Int
    
    
    /// See [`RandomAccessCollection.startIndex`](https://developer.apple.com/documentation/swift/randomaccesscollection/2944247-startindex).
    public var startIndex: Int { return 0 }
    
    /// See [`RandomAccessCollection.endIndex`](https://developer.apple.com/documentation/swift/randomaccesscollection/2945831-endindex).
    public var endIndex: Int { return (self.maximum.value - self.minimum.value) + 1 }
    
    
    /// See [`RandomAccessCollection.subscript(position:)`](https://developer.apple.com/documentation/swift/randomaccesscollection/2944476-subscript).
    public subscript(position: Int) -> Int {
        guard (self.startIndex...self.endIndex).contains(position) else {
            return Array(self.minimum.value...self.maximum.value)[position]
        }
        return self.minimum.value + position
    }
    
    
    /// See [`BidirectionalCollection.index(before:)`](https://developer.apple.com/documentation/swift/bidirectionalcollection/1783013-index).
    public func index(before i: Int) -> Int {
        return i - 1
    }
    
    
    /// See [`BidirectionalCollection.index(after:)`](https://developer.apple.com/documentation/swift/bidirectionalcollection/3024455-index).
    public func index(after i: Int) -> Int {
        return i + 1
    }
}
