import Countries
import Vapor

extension Order.Payer {
    
    /// The payer information for an order's payer.
    public struct Info: Content, Equatable {
        
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
        public var email: Optional127String
        
        /// The birth date of the payer, in [Internet date format](https://tools.ietf.org/html/rfc3339#section-5.6).
        public var birthdate: TimelessDate?
        
        /// The payer's tax ID. Supported for the PayPal payment method only.
        ///
        /// Maximum length: 14.
        public var tax: Failable<String?, NotNilValidate<Length14>>
        
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
            email: Optional127String,
            birthdate: Date?,
            tax: Failable<String?, NotNilValidate<Length14>>,
            taxType: TaxType?,
            country: Country?,
            billing: Address?
        ) {
            self.salutation = nil
            self.firstname = nil
            self.middlename = nil
            self.lastname = nil
            self.suffix = nil
            self.payer = nil
            
            self.email = email
            self.birthdate = birthdate.map(TimelessDate.init)
            self.tax = tax
            self.taxType = taxType
            self.country = country
            self.billing = billing
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.birthdate = try container.decodeIfPresent(TimelessDate.self, forKey: .birthdate)
            self.salutation = try container.decodeIfPresent(String.self, forKey: .salutation)
            self.firstname = try container.decodeIfPresent(String.self, forKey: .firstname)
            self.middlename = try container.decodeIfPresent(String.self, forKey: .middlename)
            self.lastname = try container.decodeIfPresent(String.self, forKey: .lastname)
            self.suffix = try container.decodeIfPresent(String.self, forKey: .suffix)
            self.payer = try container.decodeIfPresent(String.self, forKey: .payer)
            self.email = try container.decode(Optional127String.self, forKey: .email)
            self.tax = try container.decode(Failable<String?, NotNilValidate<Length14>>.self, forKey: .tax)
            self.taxType = try container.decodeIfPresent(TaxType.self, forKey: .taxType)
            self.country = try container.decodeIfPresent(Country.self, forKey: .country)
            self.billing = try container.decodeIfPresent(Address.self, forKey: .billing)
        }
        
        /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encodeIfPresent(self.birthdate, forKey: .birthdate)
            try container.encodeIfPresent(self.salutation, forKey: .salutation)
            try container.encodeIfPresent(self.firstname, forKey: .firstname)
            try container.encodeIfPresent(self.middlename, forKey: .middlename)
            try container.encodeIfPresent(self.lastname, forKey: .lastname)
            try container.encodeIfPresent(self.suffix, forKey: .suffix)
            try container.encodeIfPresent(self.payer, forKey: .payer)
            try container.encode(self.email, forKey: .email)
            try container.encode(self.tax, forKey: .tax)
            try container.encodeIfPresent(self.taxType, forKey: .taxType)
            try container.encodeIfPresent(self.country, forKey: .country)
            try container.encodeIfPresent(self.billing, forKey: .billing)
            
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
