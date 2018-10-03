import Vapor

/// Credit card information used for making a payment.
public struct CreditCard: Content, ValidationSetable, Equatable {
    
    /// The PayPal-generated ID for the resource.
    public let id: String?
    
    /// The card number.
    public var number: String
    
    /// The card type. For example, Visa, MasterCard, and so on.
    public var type: String
    
    /// The two-digit card expiry month, in `MM` format. Value is from `01` to `12`.
    ///
    /// This property can be set using the `CreditCard.set(_:)` method, which
    /// will validate the new value before it is assigned to the property.
    public var expireMonth: Int
    
    /// The four-digit card expiry year, in `YYYY` format.
    ///
    /// This property can be set using the `CreditCard.set(_:)` method, which
    /// will validate the new value before it is assigned to the property.
    public var expireYear: Int
    
    /// The card validation code. Supported only when making a payment but not when saving a credit card for future use.
    public var ccv2: Int?
    
    /// The first name of the card holder.
    public var firstName: String?
    
    /// The last name of the card holder.
    public var lastName: String?
    
    /// The billing address associated with this card.
    public var billingAddress: Address?
    
    /// The facilitator-provided ID of the customer who owns this bank account.
    /// Required when storing a funding instrument or using a stored funding instrument in the PayPal vault.
    ///
    /// This property can be set using the `CreditCard.set(_:)` method, which
    /// will validate the new value before it is assigned to the property.
    ///
    /// Maximum length: 256.
    public private(set) var customerID: String?
    
    /// The state of the funding instrument.
    public let state: CreditCardState?
    
    /// The date and time when the credit card becomes unusable from the vault.
    /// The `valid_until` parameter is not the same as the expiration month and year.
    /// The expiration month and year might be later than the `valid_until` date. For example,
    /// the card expires in November 2019 but the `valid_until` date is October 17th, 2019.
    public let validUntil: Date?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    /// Creates a new `CreditCard` instance.
    ///
    ///     CreditCard(
    ///         number: "4953912847443848",
    ///         type: "Visa",
    ///         expireMonth: 09,
    ///         expireYear: 2028,
    ///         ccv2: 633,
    ///         firstName: "Jonnas",
    ///         lastName: "Futher",
    ///         billingAddress: nil,
    ///         customerID: "5FC894A2-FDA7-416D-818F-C0678C57371F"
    ///     )
    public init(
        number: String,
        type: String,
        expireMonth: Int,
        expireYear: Int,
        ccv2: Int?,
        firstName: String?,
        lastName: String?,
        billingAddress: Address?,
        customerID: String?
    )throws {
        self.id = nil
        self.state = nil
        self.validUntil = nil
        self.links = nil
        
        self.number = number
        self.type = type
        self.expireMonth = expireMonth
        self.expireYear = expireYear
        self.ccv2 = ccv2
        self.firstName = firstName
        self.lastName = lastName
        self.billingAddress = billingAddress
        self.customerID = customerID
        
        try self.set(\.expireMonth <~ expireMonth)
        try self.set(\.expireYear <~ expireYear)
        try self.set(\.customerID <~ customerID)
    }
    
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.state = try container.decodeIfPresent(CreditCardState.self, forKey: .state)
        self.validUntil = try container.decodeIfPresent(Date.self, forKey: .validUntil)
        self.links = try container.decodeIfPresent([LinkDescription].self, forKey: .links)
        
        self.number = try container.decode(String.self, forKey: .number)
        self.type = try container.decode(String.self, forKey: .type)
        self.expireMonth = try container.decode(Int.self, forKey: .expireMonth)
        self.expireYear = try container.decode(Int.self, forKey: .expireYear)
        self.ccv2 = try container.decodeIfPresent(Int.self, forKey: .ccv2)
        self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        self.billingAddress = try container.decodeIfPresent(Address.self, forKey: .billingAddress)
        self.customerID = try container.decodeIfPresent(String.self, forKey: .customerID)
        
        try self.set(\.expireMonth <~ expireMonth)
        try self.set(\.expireYear <~ expireYear)
        try self.set(\.customerID <~ customerID)
    }
    
    public func setterValidations() -> SetterValidations<CreditCard> {
        var validations = SetterValidations(CreditCard.self)
        
        validations.set(\.expireMonth) { month in
            guard month > 0 && month <= 12 else {
                throw PayPalError(status: .badRequest, identifier: "invalidDate", reason: "`expire_month` property must have a value from 1 to 12.")
            }
        }
        validations.set(\.expireYear) { year in
            guard String(describing: year).count == 4 else {
                throw PayPalError(status: .badRequest, identifier: "invalidDate", reason: "`expire_year` property must have 4 digits.")
            }
        }
        validations.set(\.customerID) { id in
            guard id?.count ?? 0 <= 256 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`external_customer_id` property must have a length of 128 or less")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case id, state, links, number, type, ccv2
        case validUntil = "valid_until"
        case expireMonth = "expire_month"
        case expireYear = "expire_year"
        case firstName = "first_name"
        case lastName = "last_name"
        case billingAddress = "billing_address"
        case customerID = "external_customer_id"
    }
}
