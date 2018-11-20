import Vapor

/// Information on a business owner, which owns an account.
public struct BusinessOwner: Content, ValidationSetable, Equatable {
    
    /// The account holder's email address, in [Simple Mail Transfer Protocol](https://www.ietf.org/rfc/rfc5321.txt) as defined in RFC 5321 or
    /// in [Internet Message Format](https://www.ietf.org/rfc/rfc5322.txt) as defined in RFC 5322. Does not support Unicode email addresses.
    ///
    /// This property can be set using the `BusinessOwner.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    ///
    /// Minimum length: 3. Maximum length: 254. Pattern: `^.+@[^"\-].+$`.
    public private(set) var email: String
    
    /// The account holder's name.
    public var name: Name
    
    /// An array of relationships for the account holder.
    public var relationships: [AccountOwnerRelationship]?
    
    /// The [two-character IS0-3166-1 country code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/)
    /// of the account holder's country of residence.
    ///
    /// Length: 2. Pattern: `^([A-Z]{2}|C2)$`.
    public var country: Country
    
    /// An array of addresses for the account holder.
    public var addresses: [Address]
    
    /// The account holder's date of birth, in [Internet date and time `full-date` format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// Supports `YYYY-MM-DD`. Not required for all countries.
    ///
    /// This property can be set using the `BusinessOwner.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    ///
    /// Length: 10. Pattern: `^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$`.
    public private(set) var birthdate: String?
    
    /// The [language code](https://developer.paypal.com/docs/integration/direct/rest/locale-codes/) for the account holder's preferred language.
    public var language: Language?
    
    /// An array of phone numbers for the account holder. Includes the type, which is `HOME` or `MOBILE`.
    public var phones: [TypedPhoneNumber]?
    
    /// An array of identification documents for the account holder. This field is only required when `/business_info/type` is set to `INDIVIDUAL`
    /// or `PROPRIETORSHIP`. When required, this property must contain an identification whose `type` is set to `SOCIAL_SECURITY_NUMBER`.
    public var ids: [Identification]?
    
    /// The account holder's occupation.
    public var occupation: String?
    
    
    /// Creates a new `BusinessOwner` instance.
    ///
    ///     BusinessOwner(
    ///         email: "business@example.com",
    ///         name: Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "Bart.", full: "Sir Walter Scott"),
    ///         relationships: [],
    ///         country: "UK",
    ///         addresses: [],
    ///         birthdate: "1771-08-15",
    ///         language: .en_GB,
    ///         phones: [],
    ///         ids: [],
    ///         occupation: "Author"
    ///     )
    public init(
        email: String,
        name: Name,
        relationships: [AccountOwnerRelationship]?,
        country: Country,
        addresses: [Address],
        birthdate: String?,
        language: Language?,
        phones: [TypedPhoneNumber]?,
        ids: [Identification]?,
        occupation: String?
    )throws {
        self.email = email
        self.name = name
        self.relationships = relationships
        self.country = country
        self.addresses = addresses
        self.birthdate = birthdate
        self.language = language
        self.phones = phones
        self.ids = ids
        self.occupation = occupation
        
        try self.set(\.email <~ email)
        try self.set(\.country <~ country)
        try self.set(\.birthdate <~ birthdate)
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let email = try container.decode(String.self, forKey: .email)
        let birthdate = try container.decodeIfPresent(String.self, forKey: .birthdate)
        
        self.email = email
        self.birthdate = birthdate
        self.country = try container.decode(Country.self, forKey: .country)
        self.name = try container.decode(Name.self, forKey: .name)
        self.relationships = try container.decodeIfPresent([AccountOwnerRelationship].self, forKey: .relationships)
        self.addresses = try container.decode([Address].self, forKey: .addresses)
        self.language = try container.decodeIfPresent(Language.self, forKey: .language)
        self.phones = try container.decodeIfPresent([TypedPhoneNumber].self, forKey: .phones)
        self.ids = try container.decodeIfPresent([Identification].self, forKey: .ids)
        self.occupation = try container.decodeIfPresent(String.self, forKey: .occupation)
        
        try self.set(\.email <~ email)
        try self.set(\.birthdate <~ birthdate)
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<BusinessOwner> {
        var validations = SetterValidations(BusinessOwner.self)
        
        validations.set(\.email) { email in
            guard email.range(of: "^.+@[^\"\\-].+$", options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`email` value must match the RegEx pattern `^.+@[^\"\\-].+$`")
            }
        }
        validations.set(\.birthdate) { birthdate in
            let pattern = "^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$"
            guard birthdate?.range(of: pattern, options: .regularExpression) != nil else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`birthdate` value must match the RegEx pattern `\(pattern)`")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case email, name, addresses, phones, occupation
        case relationships = "account_owner_relationships"
        case country = "country_code_of_nationality"
        case birthdate = "date_of_birth"
        case language = "language_code"
        case ids = "identifications"
    }
}
