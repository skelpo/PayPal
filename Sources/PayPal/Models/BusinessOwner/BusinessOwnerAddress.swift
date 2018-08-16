import Vapor

extension BusinessOwner {
    public struct Address {}
}

extension BusinessOwner.Address {
    
    /// The address type, which defines what location type the address goes to.
    public enum AddressType: String, Hashable, CaseIterable, Content {
        
        /// `HOME`
        case home = "HOME"
        
        /// `WORK`
        case work = "WORK"
        
        /// `PRINCIPAL_BUSINESS`
        case principal = "PRINCIPAL_BUSINESS"
        
        /// `REGISTERED_OFFICE`
        case office = "REGISTERED_OFFICE"
        
        /// `MAILING_ADDRESS`
        case mailing = "MAILING_ADDRESS"
    }
}
