import Vapor

public struct Name: Content, Equatable {
    public var prefix: String?
    public var given: String?
    public var surname: String?
    public var middle: String?
    public var suffix: String?
    public var full: String?
    
    public init(prefix: String?, given: String?, surname: String?, middle: String?, suffix: String?, full: String?) {
        self.prefix = prefix
        self.given = given
        self.surname = surname
        self.middle = middle
        self.suffix = suffix
        self.full = full
    }
}
