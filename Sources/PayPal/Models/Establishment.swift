import Vapor

public struct Establishment: Content, Equatable {
    public var state: String?
    public var country: String?
    
    public init(state: String?, country: String?) {
        self.state = state
        self.country = country
    }
}
