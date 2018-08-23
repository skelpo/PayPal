import Vapor

/// A sales venue for a business to seel products through.
public struct SalesVenue: Content, Equatable {
    
    /// The type of sales venue for the business.
    public var type: Venue?
    
    /// The eBay ID.
    public var ebayID: String?
    
    /// The description of the business sales venue.
    public var description: String?
    
    
    /// Creates a new `SalesVenue` instance.
    ///
    ///     SalesVenue(type: .ebay, ebayID: "D6013453-B76E-4CDD-A021-DFD31A4031FE", description: "Online Ebay Store")
    public init(type: Venue?, ebayID: String?, description: String?) {
        self.type = type
        self.ebayID = ebayID
        self.description = description
    }
}
