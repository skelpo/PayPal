import Vapor

extension Business {
    
    /// A person or business that acts as a stakeholder to a business.
    public struct Stakeholder: Content, Equatable {
        
        /// The percentage ownership for a stakeholder. Pertains only to the `BENEFICIAL_OWNER` type.
        public var ownership: String?
        
        /// The type of stakeholder in the business.
        public var type: StakeholderType?
        
        /// The [two-character IS0-3166-1 country code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/)
        /// of the country of residence.
        ///
        /// Pattern: `^([A-Z]{2}|C2)$`
        public var country: Country?
        
        /// The date of birth, in [Internet date and time `full-date` format](https://tools.ietf.org/html/rfc3339#section-5.6).
        /// Supports the `YYYY-MM-DD` format.
        public var birth: TimelessDate?
        
        /// The name of the stakeholder.
        public var name: PayPal.Name?
        
        /// An array of stakeholder addresses.
        public var addresses: [Address]?
        
        /// An array of stakeholder phone numbers. Includes phone type.
        public var phones: [TypedPhoneNumber]?
        
        /// An array of stakeholder identification documents.
        public var ids: [Identification]?
        
        /// The place of birth.
        public var birthplace: BirthPlace?
        
        
        /// Creates a new `Business.Stakeholder` instance.
        ///
        ///     Stakeholder(
        ///         type: .partner
        ///         country: "US",
        ///         birth: TimelessDate(date: "2000-06-18"),
        ///         name: Name(prefix: "Sir", given: "Walter", surname: "Scott", middle: nil, suffix: "auth.", full: "Sir Walter Scott"),
        ///         addresses: [],
        ///         phones: [],
        ///         ids: [],
        ///         birthplace: BirthPlace(country: "US", city: "Boston")
        ///     )
        public init(
            ownership: String? = nil,
            type: StakeholderType?,
            country: Country?,
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
        
        enum CodingKeys: String, CodingKey {
            case type, name, addresses, phones
            case ownership = "ownership_percentage"
            case country = "country_code_of_nationality"
            case birth = "date_of_birth"
            case ids = "identifications"
            case birthplace = "place_of_birth"
        }
    }
}
