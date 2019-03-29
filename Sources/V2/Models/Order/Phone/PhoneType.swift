/// The type of phone that a phone number is connected to.
public enum PhoneType: String, Hashable, Codable, CaseIterable {
    
    /// `FAX` type.
    case fax = "FAX"
    
    /// `HOME` type.
    case home = "HOME"
    
    /// `MOBILE` type.
    case mobile = "MOBILE"
    
    /// `OTHER` type.
    case other = "OTHER"
    
    /// `PAGER` type.
    case pager = "PAGER"
}
