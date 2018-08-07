import Vapor

extension UserInfo {
    
    /// The address info for a user.
    public struct Address: Content, Equatable {
        
        /// The full street address. Can include the house number and street name.
        public let streetAddress: String?
        
        /// The city or locality.
        public let locality: String?
        
        /// The state, province, prefecture, or region.
        public let region: String?
        
        /// The zip code or postal code.
        public let zip: String?
        
        /// The country.s
        public let country: String?
        
        enum CodingKeys: String, CodingKey {
            case locality, region, country
            case streetAddress = "street_address"
            case zip = "postal_code"
        }
    }
}
