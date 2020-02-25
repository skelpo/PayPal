import Foundation
import PayPal

/// The credit card data sotred in PayPal Vault.
public struct CreditCard: Codable {

    /// The ID of the vaulted credit card, which you can use to fund a payment.
    public let id: String?

    /// The credit card number. Value is a string of numeric characters with no spaces or punctuation.
    /// Must conform to modulo and the required length for the credit card type. Redacted in responses.
    public var number: Failable<String, Number>
    
    /// The credit card type.
    public var type: CreditCardType
    
    /// A date in the month and year that the card expires.
    public var expiry: Date
    
    /// The first name of the credit card holder.
    public var firstName: Failable<String?, NotNilValidate<FirstName>>
    
    /// The last name of the credit card holder.
    public var lastName: String?
    
    /// The billing address for this card. Supports only the `address_line_1`, `address_line_2`, `admin_area_1`,
    /// `admin_area_2`, `postal_code`, and `country_code` properties.
    public var billing: Address?
    
    /// The externally-provided ID of the customer.
    public var externalCustomer: Failable<String?, NotNilValidate<Length256>>
    
    /// The ID of the merchant.
    public var merchant: Failable<String?, NotNilValidate<Length256>>
    
    /// The externally-provided ID of the credit card.
    public var externalCard: Failable<String?, NotNilValidate<Length256>>

    /// The state of the credit card funding instrument.
    public let state: State?

    /// The date and time when the vaulted credit card was created.
    public let created: ISO8601Date?

    /// The date and time when the vaulted credit card was updated.
    public let updated: ISO8601Date?

    /// The date and time when the credit card becomes unusable from the vault. The `valid_until` parameter is not the same
    /// as the expiration month and year. The expiration month and year might be later than the `valid_until` date.
    /// For example, the card expires in November 2019 but the `valid_until` date is October 17th, 2019.
    public let valueTo: ISO8601Date?

    /// An array of request-related
    /// [HATEOAS links](https://developer.paypal.com/docs/api/reference/api-responses/#hateoas-links).
    public let links: [LinkDescription]?

    /// Creates a new `CreditCard` instance.
    ///
    /// - Parameters:
    ///   - number: The credit card number.
    ///   - type: The credit card type.
    ///   - expiry: A date in the month and year that the card expires.
    ///   - firstName: The first name of the credit card holder.
    ///   - lastName: The last name of the credit card holder.
    ///   - billing: The billing address for this card.
    ///   - externalCustomer: The externally-provided ID of the customer.
    ///   - merchant: The ID of the merchant.
    ///   - externalCard: The externally-provided ID of the credit card.
    public init(
        number: Failable<String, Number>,
        type: CreditCardType,
        expiry: Date,
        firstName: Failable<String?, NotNilValidate<FirstName>>,
        lastName: String?,
        billing: Address?,
        externalCustomer: Failable<String?, NotNilValidate<Length256>>,
        merchant: Failable<String?, NotNilValidate<Length256>>,
        externalCard: Failable<String?, NotNilValidate<Length256>>
    ) {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone

        self.id = nil
        self.state = nil
        self.created = nil
        self.updated = nil
        self.valueTo = nil
        self.links = nil

        self.number = number
        self.type = type
        self.expiry = calendar.date(from: calendar.dateComponents([.year, .month], from: expiry)) ?? expiry
        self.firstName = firstName
        self.lastName = lastName
        self.billing = billing
        self.externalCustomer = externalCustomer
        self.merchant = merchant
        self.externalCard = externalCard
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let expireMonth = try Int(container.decode(String.self, forKey: .expiryMonth))
        let expireYear = try Int(container.decode(String.self, forKey: .expiryYear))
        guard
            let expiry = Calendar(identifier: .iso8601).date(from: DateComponents(
                timeZone: TimeZone(secondsFromGMT: 0),
                year: expireYear,
                month: expireMonth
            ))
        else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: [CodingKeys.expiryYear, CodingKeys.expiryMonth],
                debugDescription: "Cannot convert `expire_month` and `expire_year` values to a vlid date"
            ))
        }
        
        self.expiry = expiry
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.number = try container.decode(Failable<String, Number>.self, forKey: .number)
        self.type = try container.decode(CreditCardType.self, forKey: .type)
        self.firstName = try container.decode(Failable<String?, NotNilValidate<FirstName>>.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.billing = try container.decodeIfPresent(Address.self, forKey: .billing)
        self.externalCustomer = try container.decode(Failable<String?, NotNilValidate<Length256>>.self, forKey: .externalCustomer)
        self.merchant = try container.decode(Failable<String?, NotNilValidate<Length256>>.self, forKey: .merchant)
        self.externalCard = try container.decode(Failable<String?, NotNilValidate<Length256>>.self, forKey: .externalCard)
        self.state = try container.decodeIfPresent(State.self, forKey: .state)
        self.created = try container.decodeIfPresent(ISO8601Date.self, forKey: .created)
        self.updated = try container.decodeIfPresent(ISO8601Date.self, forKey: .updated)
        self.valueTo = try container.decodeIfPresent(ISO8601Date.self, forKey: .validTo)
        self.links = try container.decodeIfPresent([LinkDescription].self, forKey: .links)
    }
    
    /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let calendar = Calendar(identifier: .iso8601)
        let components = calendar.dateComponents([.year, .month], from: self.expiry)
        try container.encodeIfPresent(components.year.map(String.init(describing:)), forKey: .expiryYear)
        try container.encodeIfPresent(components.month.map(String.init(describing:)), forKey: .expiryMonth)

        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encode(self.number, forKey: .number)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.firstName, forKey: .firstName)
        try container.encodeIfPresent(self.lastName, forKey: .lastName)
        try container.encodeIfPresent(self.billing, forKey: .billing)
        try container.encode(self.externalCustomer, forKey: .externalCustomer)
        try container.encode(self.merchant, forKey: .merchant)
        try container.encode(self.externalCard, forKey: .externalCard)
        try container.encodeIfPresent(self.state, forKey: .state)
        try container.encodeIfPresent(self.created, forKey: .created)
        try container.encodeIfPresent(self.updated, forKey: .updated)
        try container.encodeIfPresent(self.valueTo, forKey: .validTo)
        try container.encodeIfPresent(self.links, forKey: .links)
    }
    
    /// The validator for the `CardCard.number` property value.
    public struct Number: RegexValidation {
        
        /// See `RegexValidator.patter`.
        public static let pattern: String = #"^\d{13,19}$"#
    }
    
    /// The validator for the `CreditCard.firstName` property value.
    public struct FirstName: StringLengthValidation {
        
        /// See `StringLengthValidation.maxLength`.
        public static let maxLength: Int = 25
    }

    /// The states of a credit card funding instrument.
    public enum State: String, Hashable, CaseIterable, Codable {

        /// The credit card is past it's expiration date.
        case expired

        /// The creadit card has not expired yet.
        case ok
    }

    enum CodingKeys: String, CodingKey {
        case id, number, type, state, links
        case expiryMonth = "expire_month"
        case expiryYear = "expire_year"
        case firstName = "first_name"
        case lastName = "last_name"
        case billing = "billing_address"
        case externalCustomer = "external_customer_id"
        case merchant = "merchant_id"
        case externalCard = "external_card_id"
        case created = "create_time"
        case updated = "update_time"
        case validTo = "valid_until"
    }
}

/// The valid card brand or network options for a `CreditCard` instance.
public enum CreditCardType: String, Hashable, CaseIterable, Codable {
    
    /// `visa`.
    case visa
    
    /// `mastercard`.
    case mastercard
    
    /// `amex`.
    case amex
    
    /// `discover`.
    case discover
    
    /// `maestro`.
    case maestro
}
