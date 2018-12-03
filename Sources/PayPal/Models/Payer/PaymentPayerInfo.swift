import Vapor

extension Order.Payer {
    
    /// The payer information for an order's payer.
    public struct Info: Content, ValidationSetable, Equatable {
        
        /// The payer's salutation.
        public let salutation: String?
        
        /// The payer's first name.
        public let firstname: String?
        
        /// The payer's middle name.
        public let middlename: String?
        
        /// The payer's last name.
        public let lastname: String?
        
        /// The payer's suffix.
        public let suffix: String?
        
        /// The PayPal-assigned encrypted payer ID.
        public let payer: String?
        
        
        /// The payer's email address. Maximum length is 127 characters.
        ///
        /// This property can be set using the `Inof.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        public private(set) var email: String?
        
        /// The birth date of the payer, in [Internet date format](https://tools.ietf.org/html/rfc3339#section-5.6). For example, `1990-04-12`.
        public var birthdate: String?
        
        /// The payer's tax ID. Supported for the PayPal payment method only.
        ///
        /// This property can be set using the `Inof.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 14.
        public private(set) var tax: String?
        
        /// The payer's tax ID type. Supported for the PayPal payment method only.
        public var taxType: TaxType?
        
        /// The payer's [two-character IS0-3166-1 country code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/).
        public var country: Country?
        
        /// The payer's billing address.
        public var billing: Address?
        
        
        /// Creates a mew `Order.Payer.Info` instance.
        ///
        /// - Parameters:
        ///   - email: The payer's email address.
        ///   - birthdate: The birth date of the payer.
        ///   - tax: The payer's tax ID.
        ///   - taxType: The payer's tax ID type.
        ///   - country: The payer's country code.
        ///   - billing: The payer's billing address.
        public init(
            email: String?,
            birthdate: String?,
            tax: String?,
            taxType: TaxType?,
            country: Country?,
            billing: Address?
        )throws {
            self.salutation = nil
            self.firstname = nil
            self.middlename = nil
            self.lastname = nil
            self.suffix = nil
            self.payer = nil
            
            self.email = email
            self.birthdate = birthdate
            self.tax = tax
            self.taxType = taxType
            self.country = country
            self.billing = billing
            
            try self.set(\.email <~ email)
            try self.set(\.tax <~ tax)
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.salutation = try container.decodeIfPresent(String.self, forKey: .salutation)
            self.firstname = try container.decodeIfPresent(String.self, forKey: .firstname)
            self.middlename = try container.decodeIfPresent(String.self, forKey: .middlename)
            self.lastname = try container.decodeIfPresent(String.self, forKey: .lastname)
            self.suffix = try container.decodeIfPresent(String.self, forKey: .suffix)
            self.payer = try container.decodeIfPresent(String.self, forKey: .payer)
            self.email = try container.decodeIfPresent(String.self, forKey: .email)
            self.birthdate = try container.decodeIfPresent(String.self, forKey: .birthdate)
            self.tax = try container.decodeIfPresent(String.self, forKey: .tax)
            self.taxType = try container.decodeIfPresent(TaxType.self, forKey: .taxType)
            self.country = try container.decodeIfPresent(Country.self, forKey: .country)
            self.billing = try container.decodeIfPresent(Address.self, forKey: .billing)
            
            try self.set(\.email <~ email)
            try self.set(\.tax <~ tax)
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Info> {
            var validations = SetterValidations(Info.self)
            
            validations.set(\.email) { email in
                guard email?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`email` value must have a length of 127 or less")
                }
            }
            validations.set(\.tax) { tax in
                guard tax?.count ?? 0 <= 14 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`tax_id` value must have a length of 14 or less")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case email, salutation, suffix
            case firstname = "first_name"
            case middlename = "middle_name"
            case lastname = "last_name"
            case payer = "payer_id"
            case birthdate = "birth_date"
            case tax = "tax_id"
            case taxType = "tax_id_type"
            case country = "country_code"
            case billing = "billing_address"
        }
    }
}

extension Order.Payer {
    
    /// A payer's tax ID type.
    public enum TaxType: String, Hashable, CaseIterable, Content {
        
        /// BR CPF tax ID type.
        case cpf = "BR_CPF"
        
        /// BR CNPJ tax ID type.
        case cnpj = "BR_CNPJ"
    }
}
