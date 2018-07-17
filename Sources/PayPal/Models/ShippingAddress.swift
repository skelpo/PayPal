import Vapor

public struct ShippingAddress: Content, ValidationSetable, Equatable {
    
    /// The name of the recipient at this address.
    public var recipientName: String?
    
    /// The default shipping address of the payer.
    public let defaultAddress: Bool?
    
    /// The first line of the address. For example, number or street.
    public var line1: String
    
    /// The second line of the address. For example, suite or apartment number.
    public var line2: String?
    
    /// The city name.
    public var city: String
    
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
    public private(set) var state: String?
    
    /// The [two-character ISO 3166-1 code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/) that identifies the country or region.
    ///
    /// The value must match the RegEx pattern `^([A-Z]{2}|C2)$`.
    ///
    /// - Note: The country code for Great Britain is `GB` and not `UK` as used in the top-level
    ///   domain names for that country. Use the `C2` country code for China worldwide for comparable
    ///   uncontrolled price (CUP) method, bank card, and cross-border transactions.
    public private(set) var countryCode: String
    
    /// The postal code, which is the zip code or equivalent.
    /// Typically required for countries with a postal code or an equivalent.
    /// See [postal code](https://en.wikipedia.org/wiki/Postal_code).
    public var postalCode: String?
    
    /// Creates a new `ShippingAddress` instance.
    ///
    ///     ShippingAddress(
    ///         recipientName: "Puffin Billy",
    ///         defaultAddress: true,
    ///         line1: "89 Furnace Dr.",
    ///         line2: nil,
    ///         city: "Nowhere",
    ///         state: "KS",
    ///         countryCode: "US",
    ///         postalCode: "66167"
    ///     )
    ///
    /// This initializer validates the `state` and `countryCode` values passed in.
    public init(
        recipientName: String?,
        defaultAddress: Bool?,
        line1: String,
        line2: String?,
        city: String,
        state: String?,
        countryCode: String,
        postalCode: String
    )throws {
        self.recipientName = recipientName
        self.defaultAddress = defaultAddress
        self.line1 = line1
        self.line2 = line2
        self.city = city
        self.state = state
        self.countryCode = countryCode
        self.postalCode = postalCode
        
        try self.set(\.state <~ state)
        try self.set(\.countryCode <~ countryCode)
    }
    
    /// Creates a new instance of `ShippingAddress` from that data coontained
    /// in a decoder. Validates the `state` and `countryCode` values passed in.
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            recipientName: container.decodeIfPresent(String.self, forKey: .recipientName),
            defaultAddress: container.decodeIfPresent(Bool.self, forKey: .defaultAddress),
            line1: container.decode(String.self, forKey: .line1),
            line2: container.decodeIfPresent(String.self, forKey: .line2),
            city: container.decode(String.self, forKey: .city),
            state: container.decodeIfPresent(String.self, forKey: .state),
            countryCode: container.decode(String.self, forKey: .countryCode),
            postalCode: container.decode(String.self, forKey: .postalCode)
        )
    }
    
    /// Compares two `ShippingAddress` objects, checking properties for equality.
    public static func == (lhs: ShippingAddress, rhs: ShippingAddress) -> Bool {
        return
            (lhs.recipientName == rhs.recipientName) &&
            (lhs.defaultAddress == rhs.defaultAddress) &&
            (lhs.line1 == rhs.line1) &&
            (lhs.line2 == rhs.line2) &&
            (lhs.city == rhs.city) &&
            (lhs.state == rhs.state) &&
            (lhs.countryCode == rhs.countryCode) &&
            (lhs.postalCode == rhs.postalCode)
    }
    
    public static func setterValidations() -> SetterValidations<ShippingAddress> {
        var validations = SetterValidations(ShippingAddress.self)
        
        validations.set(\.state) { state in
            guard state?.count ?? 0 <= 40 else {
                throw PayPalError(
                    status: .badRequest,
                    identifier: "malformedString",
                    reason: "`ShippingAddress.state` property length can be no longer than 40 1-byte characters"
                )
            }
        }
        validations.set(\.countryCode) { code in
            guard code.range(of: "^([A-Z]{2}|C2)$", options: .regularExpression) != nil else {
                throw PayPalError(
                    status: .badRequest,
                    identifier: "malformedString",
                    reason: "`ShippingAddress.countryCode` property must match `([A-Z]{2}|C2)$` RegEx pattern"
                )
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case line1, line2, city, state
        case recipientName = "recipient_name"
        case defaultAddress = "default_address"
        case countryCode = "country_code"
        case postalCode = "postal_code"
    }
}
