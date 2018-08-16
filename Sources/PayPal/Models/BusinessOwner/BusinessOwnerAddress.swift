import Vapor

extension BusinessOwner {
    
    /// The address object structure used for a business owner.
    public struct Address: Content, ValidationSetable, Equatable {
        
        /// The address type.
        public var type: AddressType
        
        /// The first line of the address. For example, number, street, and so on.
        ///
        /// This property can be set using the `Address.set(_:)` method. This method
        /// validates the new value before assigning it to the property.
        ///
        /// Maximum length: 300.
        public private(set) var line1: String
        
        /// The second line of the address. For example, suite, apt number, and so on.
        ///
        /// This property can be set using the `Address.set(_:)` method. This method
        /// validates the new value before assigning it to the property.
        ///
        /// Maximum length: 300.
        public private(set) var line2: String?
        
        /// The third line of the address. For example, the street complement for Brazil, direction text, such as next to Walmart,
        /// or a landmark in an Indian address.
        ///
        /// This property can be set using the `Address.set(_:)` method. This method
        /// validates the new value before assigning it to the property.
        ///
        /// Maximum length: 300.
        public private(set) var line3: String?
        
        /// The suburb or neighborhood.
        ///
        /// This property can be set using the `Address.set(_:)` method. This method
        /// validates the new value before assigning it to the property.
        ///
        /// Maximum length: 300.
        public private(set) var suburb: String?
        
        /// The city.
        ///
        /// This property can be set using the `Address.set(_:)` method. This method
        /// validates the new value before assigning it to the property.
        ///
        /// Maximum length: 120.
        public private(set) var city: String
        
        /// The [code](https://developer.paypal.com/docs/integration/direct/rest/state-codes/) for a US state or the
        /// equivalent for other countries. Required for transactions if the address is in one of these countries:
        /// [Argentina](https://developer.paypal.com/docs/integration/direct/rest/state-codes/#argentina),
        /// [Brazil](https://developer.paypal.com/docs/integration/direct/rest/state-codes/#brazil),
        /// [Canada](https://developer.paypal.com/docs/integration/direct/rest/state-codes/#canada),
        /// [India](https://developer.paypal.com/docs/integration/direct/rest/state-codes/#india),
        /// [Italy](https://developer.paypal.com/docs/integration/direct/rest/state-codes/#italy),
        /// [Japan](https://developer.paypal.com/docs/integration/direct/rest/state-codes/#japan),
        /// [Mexico](https://developer.paypal.com/docs/integration/direct/rest/state-codes/#mexico),
        /// [Thailand](https://developer.paypal.com/docs/integration/direct/rest/state-codes/#thailand),
        /// or [United States](https://developer.paypal.com/docs/integration/direct/rest/state-codes/#usa).
        /// Maximum length is 40 single-byte characters.
        public var state: String?
        
        /// The [two-character ISO 3166-1 code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/) that identifies the country or region.
        ///
        /// The value must match the RegEx pattern `^([A-Z]{2}|C2)$`.
        ///
        /// - Note: The country code for Great Britain is `GB` and not `UK` as used in the top-level
        ///   domain names for that country. Use the `C2` country code for China worldwide for comparable
        ///   uncontrolled price (CUP) method, bank card, and cross-border transactions.
        public var country: String
        
        /// The postal code, which is the zip code or equivalent.
        /// Typically required for countries with a postal code or an equivalent.
        /// See [postal code](https://en.wikipedia.org/wiki/Postal_code).
        public var postalCode: String?
        
        
        /// Creates a new `BusinessOwner.Address` instance.
        ///
        ///     Address(
        ///         type: .home,
        ///         line1: "89 Furnace Dr.",
        ///         line2: nil,
        ///         line3: nil,
        ///         suburb: "Invisible Winds",
        ///         city: "Nowhere",
        ///         state: "KS",
        ///         country: "US",
        ///         postalCode: "66167"
        ///     )
        public init(
            type: AddressType,
            line1: String,
            line2: String?,
            line3: String?,
            suburb: String?,
            city: String,
            state: String?,
            country: String,
            postalCode: String?
        )throws {
            self.type = type
            self.line1 = line1
            self.line2 = line2
            self.line3 = line3
            self.suburb = suburb
            self.city = city
            self.state = state
            self.country = country
            self.postalCode = postalCode
        }
        
        
        /// See `ValidationSetable.setterValidations()`
        public func setterValidations() -> SetterValidations<BusinessOwner.Address> {
            var validations = SetterValidations(Address.self)
            
            validations.set(\.line1) { line1 in
                guard line1.count <= 300 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`line1` property length can be no longer 300")
                }
            }
            validations.set(\.line2) { line2 in
                guard line2?.count ?? 0 <= 300 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`line2` property length can be no longer 300")
                }
            }
            validations.set(\.line3) { line3 in
                guard line3?.count ?? 0 <= 300 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`line3` property length can be no longer 300")
                }
            }
            validations.set(\.suburb) { suburb in
                guard suburb?.count ?? 0 <= 300 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`suburb` property length can be no longer 300")
                }
            }
            validations.set(\.city) { city in
                guard city.count <= 120 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`city` property length can be no longer 120")
                }
            }
            validations.set(\.state) { state in
                guard state?.count ?? 0 <= 40 else {
                    throw PayPalError(
                        status: .badRequest,
                        identifier: "invalidLength", reason: "`state` property length can be no longer than 40 1-byte characters"
                    )
                }
            }
            validations.set(\.country) { code in
                guard code.range(of: "^([A-Z]{2}|C2)$", options: .regularExpression) != nil else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`country` property must match `([A-Z]{2}|C2)$` RegEx pattern")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case type = "type"
            case line1 = "line1"
            case line2 = "line2"
            case line3 = "line3"
            case suburb = "suburb"
            case city = "city"
            case state = "state"
            case country = "country_code"
            case postalCode = "postal_code"
        }
    }
}

extension BusinessOwner.Address {
    
    /// The address type, which defines what location type the address goes to.
    public enum AddressType: String, Hashable, CaseIterable, Content {
        
        /// `HOME`
        case home = "HOME"
        
        /// `WORK`
        case work = "WORK"
        
        /// `PRINCIPAL_BUSINESS`
        case principal = "PRINCIPAL_BUSINESS"
        
        /// `REGISTERED_OFFICE`
        case office = "REGISTERED_OFFICE"
        
        /// `MAILING_ADDRESS`
        case mailing = "MAILING_ADDRESS"
    }
}
