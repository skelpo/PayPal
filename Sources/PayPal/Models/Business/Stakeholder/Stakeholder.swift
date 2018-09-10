import Vapor

extension Business {
    public struct Stakeholder: Content, Equatable {
        public var ownership: String?
        public var type: StakeholderType?
        public var country: String?
        public var birth: TimelessDate?
        public var name: PayPal.Name?
        public var addresses: [Address]?
        public var phones: [TypedPhoneNumber]?
        public var ids: [Identification]?
        public var birthplace: BirthPlace?
        
        public init(
            ownership: String?,
            type: StakeholderType?,
            country: String?,
            birth: TimelessDate?,
            name: PayPal.Name?,
            addresses: [Address]?,
            phones: [TypedPhoneNumber]?,
            ids: [Identification]?,
            birthplace: BirthPlace?
        ) {
            self.ownership = ownership
            self.type = type
            self.country = country
            self.birth = birth
            self.name = name
            self.addresses = addresses
            self.phones = phones
            self.ids = ids
            self.birthplace = birthplace
        }
    }
}
