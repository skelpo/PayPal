import Vapor

extension BusinessOwner {
    
    /// An identification document for a business owner.
    public struct ID: Content, ValidationSetable, Equatable {
        
        /// The type of document to use for identification.
        public var type: IDType
        
        /// The document number.
        public var value: String
        
        /// Indicates whether the value is a partial value. Use when the identifier type supports a partial value, such as a four-digit SSN number,
        /// instead of the full nine digits. This flag may not always be honored based on the context in which it is used.
        public var masked: Bool?
        
        /// The [two-character IS0-3166-1 country code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/)
        /// of the country that issued the identity document.
        ///
        /// This property can be set with the `BusinessOwner.set(_:)`. This method
        /// validates the new value before assigning it to the property.
        ///
        /// Pattern: `^[A-Z]([A-Z]|\d)$`.
        public private(set) var issuerCountry: String
        
        /// The [state or province code](https://developer.paypal.com/docs/integration/direct/rest/state-codes/)
        /// for the state or province that issued the identity document.
        public var issuerState: String?
        
        /// The city that issued the identity document. Applies only to certain types of documents, such as `trade_registration_number` documents.
        public var issuerCity: String?
        
        /// The name of the place that issued the identity document. Applies only to some types, such as `TAX_ID` for Turkey (`TR`).
        public var placeOfIssue: String?
        
        /// A description of the entity that issued the identity document. For example, `registration authority`.
        public var description: String?
        
        
        /// Creates a new `BusinessOwner.ID` instance.
        ///
        ///     BusinessOwner.ID(
        ///         type: .driversLicense,
        ///         value: "123abc456def",
        ///         masked: false,
        ///         issuerCountry: "US",
        ///         issuerState: "OR",
        ///         issuerCity: "Portland",
        ///         placeOfIssue: nil,
        ///         description: "DMV"
        ///     )
        public init(
            type: IDType,
            value: String,
            masked: Bool?,
            issuerCountry: String,
            issuerState: String?,
            issuerCity: String?,
            placeOfIssue: String?,
            description: String?
        )throws {
            self.type = type
            self.value = value
            self.masked = masked
            self.issuerCountry = issuerCountry
            self.issuerState = issuerState
            self.issuerCity = issuerCity
            self.placeOfIssue = placeOfIssue
            self.description = description
            
            try self.set(\.issuerCountry <~ issuerCountry)
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let issuerCountry = try container.decode(String.self, forKey: .issuerCountry)
            
            self.issuerCountry = issuerCountry
            self.type = try container.decode(IDType.self, forKey: .type)
            self.value = try container.decode(String.self, forKey: .value)
            self.masked = try container.decodeIfPresent(Bool.self, forKey: .masked)
            self.issuerState = try container.decodeIfPresent(String.self, forKey: .issuerState)
            self.issuerCity = try container.decodeIfPresent(String.self, forKey: .issuerCity)
            self.placeOfIssue = try container.decodeIfPresent(String.self, forKey: .placeOfIssue)
            self.description = try container.decodeIfPresent(String.self, forKey: .description)
            
            try self.set(\.issuerCountry <~ issuerCountry)
        }
        
        /// See `ValidationSetable.setterValidations()`
        public func setterValidations() -> SetterValidations<BusinessOwner.ID> {
            var validations = SetterValidations(ID.self)
            
            validations.set(\.issuerCountry) { country in
                guard country.range(of: "^[A-Z]([A-Z]|\\d)$", options: .regularExpression) != nil else {
                    throw PayPalError(
                        status: .badRequest,
                        identifier: "malformedString",
                        reason: "`country` property must match RegEx pattern '^[A-Z]([A-Z]|\\d)$'"
                    )
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case type, value, masked
            case issuerCountry = "issuer_country_code"
            case issuerState = "issuer_state"
            case issuerCity = "issuer_city"
            case placeOfIssue = "place_of_issue"
            case description = "issuer_description"
        }
    }
}
