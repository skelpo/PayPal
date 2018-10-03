import Vapor

/// The type purpose of the phone that the phone number is connected to.
public enum PhoneType: String, Hashable, CaseIterable, Content {
    
    /// `HOME`
    case home = "HOME"
    
    /// `MOBILE`
    case mobile = "MOBILE"
    
    /// `BUSINESS`
    case business = "BUSINESS"
    
    /// `WORK`
    case work = "WORK"
    
    /// `CUSTOMER_SERVICE`
    case customerService = "CUSTOMER_SERVICE"
    
    /// `FAX`
    case fax = "FAX"
    
    /// `OTHER`
    case other = "OTHER"
    
    /// `PAGER`
    case pager = "PAGER"
}
