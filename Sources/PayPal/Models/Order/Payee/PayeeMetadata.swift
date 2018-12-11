import Vapor

extension Payee {
    
    /// The display-only metadata for a payee.
    public struct Metadata: Content, Equatable {
        
        /// The email address for the payer. Maximum length is 127 characters.
        public var email: Optional127String
        
        /// The payee's phone number.
        public var phone: DisplayPhone?
        
        /// The payer's business name.
        public var brand: String?
        
        /// Creates a new `Payee.Metadata` instance.
        ///
        /// - Parameters:
        ///   - email: The email address for the payer.
        ///   - phone: The payee's phone number.
        ///   - brand: The payer's business name.
        public init(email: Optional127String, phone: DisplayPhone?, brand: String?) {
            self.email = email
            self.phone = phone
            self.brand = brand
        }
        
        enum CodingKeys: String, CodingKey {
            case email
            case phone = "display_phone"
            case brand = "brand_name"
        }
    }
}
