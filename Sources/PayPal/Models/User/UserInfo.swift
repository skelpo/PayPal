import Vapor

public struct UserInfo: Content, Equatable {
    public let id: String?
    public let sub: String?
    public let name: String?
    public let givenName: String?
    public let familyName: String?
    public let middleName: String?
    public let picture: String?
    public let email: String?
    public let emailVerified: Bool?
    public let gender: String?
    public let birthdate: String?
    public let zoneinfo: String?
    public let locale: String?
    public let phoneNumber: String?
    public let address: Address?
    public let verified: Bool?
    public let accountType: AccountType?
    public let ageRange: String?
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
