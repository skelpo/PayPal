import Vapor

/// Information on a business owner, which owns an account.
public struct BusinessOwner: Content, Equatable {
    
    /// The account holder's email address, in [Simple Mail Transfer Protocol](https://www.ietf.org/rfc/rfc5321.txt) as defined in RFC 5321 or
    /// in [Internet Message Format](https://www.ietf.org/rfc/rfc5322.txt) as defined in RFC 5322. Does not support Unicode email addresses.
    ///
    /// Minimum length: 3. Maximum length: 254. Pattern: `^.+@[^"\-].+$`.
    public var email: String
    
    /// The account holder's name.
    public var name: Name
    
    /// An array of relationships for the account holder.
    public var relationships: [AccountOwnerRelationship]?
    
    /// The [two-character IS0-3166-1 country code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/)
    /// of the account holder's country of residence.
    ///
    /// Length: 2. Pattern: `^([A-Z]{2}|C2)$`.
    public var country: String
    
    /// An array of addresses for the account holder.
    public var addresses: [Address]
    
    /// The account holder's date of birth, in [Internet date and time `full-date` format](https://tools.ietf.org/html/rfc3339#section-5.6).
    /// Supports `YYYY-MM-DD`. Not required for all countries.
    ///
    /// Length: 10. Pattern: `^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$`.
    public var birthdate: String?
    
    /// The [language code](https://developer.paypal.com/docs/integration/direct/rest/locale-codes/) for the account holder's preferred language.
    public var language: Language?
    
    /// An array of phone numbers for the account holder. Includes the type, which is `HOME` or `MOBILE`.
    public var phones: [TypedPhoneNumber]?
    
    /// An array of identification documents for the account holder. This field is only required when `/business_info/type` is set to `INDIVIDUAL`
    /// or `PROPRIETORSHIP`. When required, this property must contain an identification whose `type` is set to `SOCIAL_SECURITY_NUMBER`.
    public var ids: [ID]?
    
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
        country: String,
        addresses: [Address],
        birthdate: String?,
        language: Language?,
        phones: [TypedPhoneNumber]?,
        ids: [ID]?,
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
    }
}
