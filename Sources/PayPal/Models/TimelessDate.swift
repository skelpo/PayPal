import Vapor

public struct TimelessDate: Content, Equatable {
    public var date: String?
    
    public init(date: String?)throws {
        self.date = date
    }
}
