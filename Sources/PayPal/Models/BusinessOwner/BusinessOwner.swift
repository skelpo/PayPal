import Vapor

public struct BusinessOwner: Content, Equatable {
    public var email: String
    public var name: Name
    public var relationships: [AccountOwnerRelationship]?
    public var country: String
    public var addresses: [Address]
    public var birthdate: String?
    public var ssn: String?
    public var language: String?
    public var phones: [TypedPhoneNumber]?
    public var ids: [ID]?
    public var occupation: String?
    
    public init(
        email: String,
        name: Name,
        relationships: [AccountOwnerRelationship]?,
        country: String,
        addresses: [Address],
        birthdate: String?,
        ssn: String?,
        language: String?,
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
        self.ssn = ssn
        self.language = language
        self.phones = phones
        self.ids = ids
        self.occupation = occupation
    }
}
