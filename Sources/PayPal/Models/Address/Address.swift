import Vapor

public struct Address: Content, Equatable {
    
    /// The address normalization status. Returned only for payers from Brazil.
    public let normalization: Normalization?
    
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
    public var state: Province?
    
    /// The [two-character ISO 3166-1 code](https://developer.paypal.com/docs/integration/direct/rest/country-codes/)
    /// that identifies the country or region.
    ///
    /// The value must match the RegEx pattern `^([A-Z]{2}|C2)$`.
    ///
    /// - Note: The country code for Great Britain is `GB` and not `UK` as used in the top-level
    ///   domain names for that country. Use the `C2` country code for China worldwide for comparable
    ///   uncontrolled price (CUP) method, bank card, and cross-border transactions.
    public var country: Country
    
    /// The postal code, which is the zip code or equivalent.
    /// Typically required for countries with a postal code or an equivalent.
    /// See [postal code](https://en.wikipedia.org/wiki/Postal_code).
    public var postalCode: String?
    
    /// The phone number, in [E.123 format](https://www.itu.int/rec/T-REC-E.123-200102-I/en). Maximum length is 50 characters.
    public var phone: String?
    
    /// The type of address. For example, `HOME_OR_WORK`, `GIFT`, and so on.
    public var type: String?
    
    /// Creates a new `Address` instance.
    ///
    ///     Address(
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
        state: Province?,
        country: Country,
        postalCode: String,
        phone: String?,
        type: String?
    ) {
        self.normalization = nil
        self.recipientName = recipientName
        self.defaultAddress = defaultAddress
        self.line1 = line1
        self.line2 = line2
        self.city = city
        self.state = state
        self.country = country
        self.postalCode = postalCode
        self.phone = phone
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case line1, line2, city, state, phone, type
        case recipientName = "recipient_name"
        case defaultAddress = "default_address"
        case country = "country_code"
        case postalCode = "postal_code"
        case normalization = "normalization_status"
    }
}
