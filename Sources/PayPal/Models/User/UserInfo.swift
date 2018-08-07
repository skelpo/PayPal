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
    public let verifiedEmail: Bool?
    public let gender: String?
    public let birthdate: String?
    public let zoneinfo: String?
    public let locale: String?
    public let phoneNumber: String?
    public let address: Address?
    public let verified: Bool?
    public let accountType: AccountType?
    public let ageRange: String?
    public let playerID: String?
}
