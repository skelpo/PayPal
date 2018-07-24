import Vapor

public struct Message: Content, Equatable {
    public let poster: Poster?
    public let posted: String?
    public var content: String?
    
    public init(content: String?) {
        self.poster = nil
        self.posted = nil
        self.content = content
    }
}
