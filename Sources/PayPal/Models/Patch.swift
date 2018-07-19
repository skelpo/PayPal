import Vapor

public struct Patch<Value>: Content, Equatable where Value: Codable & Equatable {
    public var operation: Operation
    public var path: String?
    public var value: Value?
    public var from: String?
    
    public init(operation: Operation, path: String?, value: Value?, from: String? = nil) {
        self.operation = operation
        self.path = path
        self.value = value
        self.from = from
    }
}
