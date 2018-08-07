import Vapor

public struct MerchantInfo: Content, Equatable {
    public var email: String?
    public var business: String?
    public var firstName: String?
    public var lastName: String?
    public var address: Address?
    public var phone: PhoneNumber?
    public var fax: PhoneNumber?
    public var website: String?
    public var taxID: String?
    public var info: String?
    
    public init(
        email: String?,
        business: String?,
        firstName: String?,
        lastName: String?,
        address: Address?,
        phone: PhoneNumber?,
        fax: PhoneNumber?,
        website: String?,
        taxID: String?,
        info: String?
    )throws {
        self.email = email
        self.business = business
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.phone = phone
        self.fax = fax
        self.website = website
        self.taxID = taxID
        self.info = info
    }
}
