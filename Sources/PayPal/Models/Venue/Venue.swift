import Vapor

/// The venues where merchandise can be sold.
public enum Venue: String, Hashable, CaseIterable, Content {
    
    /// `EBAY`
    case ebay = "EBAY"
    
    /// `ANOTHER_MARKET_PLACE`
    case market = "ANOTHER_MARKET_PLACE"
    
    /// `OWN_WEB_SITE`
    case website = "OWN_WEB_SITE"
    
    /// `OTHER`
    case other = "OTHER"
}
