import Vapor

public struct Document: Content, Equatable {
    public var name: String?
    public var size: String?
    
    public init(name: String?, size: String?) {
        self.name = name
        self.size = size
    }
}
