import Vapor

public struct SalesVenue: Content, Equatable {
    public var type: Venue?
    public var ebayID: String?
    public var description: String?
    
    public init(type: Venue?, ebayID: String?, description: String?) {
        self.type = type
        self.ebayID = ebayID
        self.description = description
    }
}
