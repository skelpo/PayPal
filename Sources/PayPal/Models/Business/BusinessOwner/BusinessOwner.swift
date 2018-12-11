import Vapor

/// Information on a business owner, which owns an account.
public struct BusinessOwner: Content, Equatable {
    internal static let birthdateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    /// The account holder's email address, in [Simple Mail Transfer Protocol](https://www.ietf.org/rfc/rfc5321.txt) as defined in RFC 5321 or
    /// in [Internet Message Format](https://www.ietf.org/rfc/rfc5322.txt) as defined in RFC 5322. Does not support Unicode email addresses.
    ///
    /// Minimum length: 3. Maximum length: 254. Pattern: `^.+@[^"\-].+$`.
    public var email: Failable<String, EmailString>
    
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
    /// Supports `YYYY-MM-dd`. Not required for all countries.
    public var birthdate: Date?
    
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
    /// - Parameters:
    ///   - email: The account holder's email address.
    ///   - name: The account holder's name.
    ///   - relationships: An array of relationships for the account holder.
    ///   - country: The two-character IS0-3166-1 country code of the account holder's country of residence.
    ///   - addresses: An array of addresses for the account holder.
    ///   - birthdate: The account holder's date of birth, in Internet date and time `full-date` format.
    ///   - language: The language code for the account holder's preferred language.
    ///   - phones: An array of phone numbers for the account holder.
    ///   - ids: An array of identification documents for the account holder.
    ///   - occupation: The account holder's occupation.
    public init(
        email: Failable<String, EmailString>,
        name: Name,
        relationships: [AccountOwnerRelationship]?,
        country: Country,
        addresses: [Address],
        birthdate: Date?,
        language: Language?,
        phones: [TypedPhoneNumber]?,
        ids: [Identification]?,
        occupation: String?
    ) {
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
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if
            let birthdate = try container.decodeIfPresent(String.self, forKey: .birthdate),
            let date = BusinessOwner.birthdateFormatter.date(from: birthdate)
        {
            self.birthdate = date
        }
        
        self.email = try container.decode(Failable<String, EmailString>.self, forKey: .email)
        self.country = try container.decode(Country.self, forKey: .country)
        self.name = try container.decode(Name.self, forKey: .name)
        self.relationships = try container.decodeIfPresent([AccountOwnerRelationship].self, forKey: .relationships)
        self.addresses = try container.decode([Address].self, forKey: .addresses)
        self.language = try container.decodeIfPresent(Language.self, forKey: .language)
        self.phones = try container.decodeIfPresent([TypedPhoneNumber].self, forKey: .phones)
        self.ids = try container.decodeIfPresent([Identification].self, forKey: .ids)
        self.occupation = try container.decodeIfPresent(String.self, forKey: .occupation)
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder)throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if let date = self.birthdate {
            try container.encode(BusinessOwner.birthdateFormatter.string(from: date), forKey: .birthdate)
        }
        
        try container.encode(self.email, forKey: .email)
        try container.encode(self.country, forKey: .country)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.addresses, forKey: .addresses)
        try container.encodeIfPresent(self.relationships, forKey: .relationships)
        try container.encodeIfPresent(self.language, forKey: .language)
        try container.encodeIfPresent(self.phones, forKey: .phones)
        try container.encodeIfPresent(self.ids, forKey: .ids)
        try container.encodeIfPresent(self.occupation, forKey: .occupation)
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
