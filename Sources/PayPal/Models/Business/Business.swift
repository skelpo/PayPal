import Vapor

public struct Business: Content, Equatable {
    public var type: BusinessType
    public var subType: SubType?
    public var government: GovernmentBody?
    public var establishment: Establishment?
    public var names: [Name]?
    public var ids: [Identification]?
    public var phones: [TypedPhoneNumber]
    public var category: String?
    public var subCategory: String?
    public var merchantCategory: String?
    public var establishedDate: TimelessDate?
    public var registrationDate: TimelessDate?
    public var disputeEmail: EmailAddress?
    public var sales: Sales?
    public var customerService: CustomerService?
    public var addresses: [Address]?
    public var country: String?
    public var stakeholders: [Stakeholder]?
    public var designation: Designation?
    
    public init(
        type: BusinessType,
        subType: SubType?,
        government: GovernmentBody?,
        establishment: Establishment?,
        names: [Name]?,
        ids: [Identification]?,
        phones: [TypedPhoneNumber],
        category: String?,
        subCategory: String?,
        merchantCategory: String?,
        establishedDate: TimelessDate?,
        registrationDate: TimelessDate?,
        disputeEmail: EmailAddress?,
        sales: Sales?,
        customerService: CustomerService?,
        addresses: [Address]?,
        country: String?,
        stakeholders: [Stakeholder]?,
        designation: Designation?
    )throws {
        self.type = type
        self.subType = subType
        self.government = government
        self.establishment = establishment
        self.names = names
        self.ids = ids
        self.phones = phones
        self.category = category
        self.subCategory = subCategory
        self.merchantCategory = merchantCategory
        self.establishedDate = establishedDate
        self.registrationDate = registrationDate
        self.disputeEmail = disputeEmail
        self.sales = sales
        self.customerService = customerService
        self.addresses = addresses
        self.country = country
        self.stakeholders = stakeholders
        self.designation = designation
    }
}
