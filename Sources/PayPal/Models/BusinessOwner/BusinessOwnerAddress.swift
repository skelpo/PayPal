import Vapor

extension BusinessOwner {
    public struct Address {
        public var type: AddressType
        public var line1: String
        public var line2: String?
        public var line3: String?
        public var suburb: String?
        public var city: String
        public var state: String?
        public var country: Currency
        public var postalCode: String?
        
        public init(
            type: AddressType,
            line1: String,
            line2: String?,
            line3: String?,
            suburb: String?,
            city: String,
            state: String?,
            country: Currency,
            postalCode: String?
        )throws {
            self.type = type
            self.line1 = line1
            self.line2 = line2
            self.line3 = line3
            self.suburb = suburb
            self.city = city
            self.state = state
            self.country = country
            self.postalCode = postalCode
        }
    }
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
