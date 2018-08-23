import Vapor

public struct PercentRange: Content, Equatable {
    public var minimum: Int
    public var maximum: Int
    
    public init(min: Int, max: Int) {
        self.minimum = min
        self.maximum = max
    }
}
