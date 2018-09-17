import Vapor

extension Payee {
    
    /// The display-only metadata for a payee.
    public struct Metadata: Content, ValidationSetable, Equatable {
        
        /// The email address for the payer. Maximum length is 127 characters.
        ///
        /// This property can be set using the `Metadata.set(_:)`. This method
        /// validates the new value before assigning it to the property.
        public private(set) var email: String?
        
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
        public init(email: String?, phone: DisplayPhone?, brand: String?) {
            self.email = email
            self.phone = phone
            self.brand = brand
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Payee.Metadata> {
            var validations = SetterValidations(Payee.Metadata.self)
            
            validations.set(\.email) { email in
                guard let email = email else { return }
                guard email.count <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`email` value length must be 127 or less")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case email
            case phone = "display_phone"
            case brand = "brand_name"
        }
    }
}
