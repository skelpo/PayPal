import Vapor

/// A range of percentages, including all whole numbers between a spoecified minimum and maximum values.
public struct PercentRange: Content, ValidationSetable, Hashable {
    
    /// The minimum inclusive value of the range.
    ///
    /// This property can be set using the `PercentRange.set(_:)`. This method
    /// validates the new value before assigning it to thr property.
    ///
    /// Minimum value: 0. Maximum value: 99.
    public private(set) var minimum: Int
    
    /// The maximum inclusive value of the range.
    ///
    /// This property can be set using the `PercentRange.set(_:)`. This method
    /// validates the new value before assigning it to thr property.
    ///
    /// Minimum value: 1. Maximum value: 100.
    public private(set) var maximum: Int
    
    
    /// Creates a new `PercentRange` instance.
    ///
    ///     PercentRange(min: 25, max: 75)
    public init(min: Int, max: Int)throws {
        self.minimum = min
        self.maximum = max
        
        try self.set(\.minimum <~ min)
        try self.set(\.maximum <~ max)
    }
    
    /// Creates a new `PercentRange` instance with a closed range.
    ///
    ///     PercentRange(50..<100)
    public init(_ range: Range<Int>)throws {
        self.minimum = range.lowerBound
        self.maximum = range.last ?? range.upperBound
        
        try self.set(\.minimum <~ range.lowerBound)
        try self.set(\.maximum <~ (range.last ?? range.upperBound))
    }
    
    /// Creates a new `PercentRange` instance with a closed range.
    ///
    ///     PercentRange(50...75)
    public init(_ range: ClosedRange<Int>)throws {
        self.minimum = range.lowerBound
        self.maximum = range.upperBound
        
        try self.set(\.minimum <~ range.lowerBound)
        try self.set(\.maximum <~ range.upperBound)
    }
    
    /// Creates a new `PercentRange` instance with a closed range.
    ///
    ///     PercentRange(50...)
    ///
    /// - Note: `maximum` property gets assigned `100`.
    public init(_ range: PartialRangeFrom<Int>)throws {
        self.minimum = range.lowerBound
        self.maximum = 100
        
        try self.set(\.minimum <~ range.lowerBound)
    }
    
    
    /// Creates a new `PercentRange` instance with a closed range.
    ///
    ///     PercentRange(...100)
    ///
    /// - Note: `minimum` property gets assigned `0`.
    public init(_ range: PartialRangeThrough<Int>)throws {
        self.minimum = 0
        self.maximum = range.upperBound
        
        try self.set(\.maximum <~ range.upperBound)
    }
    
    /// Creates a new `PercentRange` instance with a closed range.
    ///
    ///     PercentRange(..<100)
    ///
    /// - Note: `minimum` property gets assigned `0`.
    public init(_ range: PartialRangeUpTo<Int>)throws {
        self.minimum = 0
        self.maximum = range.upperBound - 1
        
        try self.set(\.maximum <~ (range.upperBound - 1))
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let min = try container.decode(Int.self, forKey: .minimum)
        let max = try container.decode(Int.self, forKey: .maximum)
        
        self.minimum = min
        self.maximum = max
        
        try self.set(\.minimum <~ min)
        try self.set(\.maximum <~ max)
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<PercentRange> {
        var validations = SetterValidations(PercentRange.self)
        
        validations.set(\.minimum) { min in
            guard (0...99).contains(min) else {
                throw PayPalError(status: .badRequest, identifier: "invalidPercent", reason: "`min` value must be no less than 0 and no greater then 99 (0-99)")
            }
        }
        validations.set(\.maximum) { max in
            guard (1...100).contains(max) else {
                throw PayPalError(status: .badRequest, identifier: "invalidPercent", reason: "`max` value must be no less than 1 and no greater then 100 (1-100)")
            }
        }
        
        return validations
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
        let start: Int = collection.startIndex > self.minimum && collection.startIndex < 100 ? collection.startIndex : self.minimum
        let end: Int = collection.endIndex < self.maximum && collection.endIndex > 0 ? collection.endIndex : self.maximum
        
        return Range<Int>.init(uncheckedBounds: (start, end))
    }
    
    /// See [`RangeExpression.contains(_:)`](https://developer.apple.com/documentation/swift/rangeexpression/2893202-contains)
    public func contains(_ element: Int) -> Bool {
        return element >= minimum && element <= maximum
    }
}

extension PercentRange: RandomAccessCollection {
    
    /// See [`RandomAccessCollection.Index`](https://developer.apple.com/documentation/swift/randomaccesscollection/2946102-index).
    public typealias Index = Int
    
    /// See [`RandomAccessCollection.Element`](https://developer.apple.com/documentation/swift/randomaccesscollection/2945146-element).
    public typealias Element = Int
    
    
    /// See [`RandomAccessCollection.startIndex`](https://developer.apple.com/documentation/swift/randomaccesscollection/2944247-startindex).
    public var startIndex: Int { return self.minimum }
    
    /// See [`RandomAccessCollection.endIndex`](https://developer.apple.com/documentation/swift/randomaccesscollection/2945831-endindex).
    public var endIndex: Int { return self.maximum }
    
    
    /// See [`RandomAccessCollection.subscript(position:)`](https://developer.apple.com/documentation/swift/randomaccesscollection/2944476-subscript).
    public subscript(position: Int) -> Int {
        guard self.contains(position) else {
            return Array(self.minimum...self.maximum)[position]
        }
        return position
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
