import Vapor

/// A user's profile attributes, based on the configured scopes of the REST app registered with PayPal.
public struct UserInfo: Content, Equatable {
    
    /// Identifier for the end-user at the issuer.
    public let id: String?
    
    /// The subject ID for the end user at the issuer.
    public let sub: String?
    
    /// End-User's full name in displayable form including all name parts, possibly including titles and suffixes,
    /// ordered according to the end-user's locale and preferences.
    public let name: String?
    
    /// Given name(s) or first name(s) of the end-user.
    public let givenName: String?
    
    /// Surname(s) or last name(s) of the end-user.
    public let familyName: String?
    
    /// The middle name of the end user.
    public let middleName: String?
    
    /// The URL of the end user's profile picture.
    public let picture: String?
    
    /// End-user's preferred email address.
    public let email: String?
    
    /// True if the End-User's e-mail address has been verified; otherwise false.
    public let emailVerified: Bool?
    
    /// End-user's gender.
    public let gender: String?
    
    /// End-user's birthday, represented as an `YYYY-MM-DD` format. They year MAY be `0000`, indicating it is omited.
    /// To represent only the year, `YYYY` format would be used.
    public let birthdate: String?
    
    /// Time zone database representing the End-User's time zone.
    public let zoneinfo: String?
    
    /// End-user's locale.
    public let locale: String?
    
    /// End-user's preferred telephone number.
    public let phoneNumber: String?
    
    /// End-user's preferred telephone number.
    public let address: Address?
    
    /// End-user's preferred telephone number.
    public let verified: Bool?
    
    /// Account type, either `personal` or `business`.
    public let accountType: AccountType?
    
    /// Account holder age range.
    public let ageRange: String?
    
    /// Account payer identifier.
    public let payerID: String?
    
    enum CodingKeys: String, CodingKey {
        case sub, name, picture, email, gender, birthdate, zoneinfo, locale, address
        case id = "user_id"
        case givenName = "given_name"
        case familyName = "family_name"
        case middleName = "middle_name"
        case emailVerified = "email_verified"
        case phoneNumber = "phone_number"
        case verified = "verified_account"
        case accountType = "account_type"
        case ageRange = "age_range"
        case payerID = "payer_id"
    }
}
