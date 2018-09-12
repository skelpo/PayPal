import Vapor

public struct AccountError: Content, Error, Equatable {
    public let information: String?
    public let links: [LinkDescription]?
    
    public var name: String
    public var message: String
    public var debug: String
    public var details: [Details]?
    
    public init(name: String, message: String, debug: String, details: [Details]?) {
        self.information = nil
        self.links = nil
        
        self.name = name
        self.message = message
        self.debug = debug
        self.details = details
    }
}
