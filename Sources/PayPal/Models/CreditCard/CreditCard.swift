import Vapor

/// Credit card information used for making a payment.
public struct CreditCard: Content, Equatable {
    
    /// The PayPal-generated ID for the resource.
    public let id: String?
    
    /// The card number.
    public var number: String
    
    /// The card type. For example, Visa, MasterCard, and so on.
    public var type: String
    
    /// The two-digit card expiry month, in `MM` format. Value is from `01` to `12`.
    public var expireMonth: Failable<Int, MonthRange>
    
    /// The four-digit card expiry year, in `YYYY` format.
    public var expireYear: Failable<Int, YearRange>
    
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
    /// Maximum length: 256.
    public var customerID: Failable<String?, NotNilValidate<Length256>>
    
    /// The state of the funding instrument.
    public let state: CreditCard.State?
    
    /// The date and time when the credit card becomes unusable from the vault.
    /// The `valid_until` parameter is not the same as the expiration month and year.
    /// The expiration month and year might be later than the `valid_until` date. For example,
    /// the card expires in November 2019 but the `valid_until` date is October 17th, 2019.
    public let validUntil: Date?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    /// Creates a new `CreditCard` instance.
    ///
    /// - Parameters:
    ///   - number: The card number.
    ///   - type: The card type. For example, Visa, MasterCard, and so on.
    ///   - expireMonth: The two-digit card expiry month, in `MM` format.
    ///   - expireYear: The four-digit card expiry year, in `YYYY` format.
    ///   - ccv2: The card validation code.
    ///   - firstName: The first name of the card holder.
    ///   - lastName: The last name of the card holder.
    ///   - billingAddress: The billing address associated with this card.
    ///   - customerID: The facilitator-provided ID of the customer who owns this bank account.
    public init(
        number: String,
        type: String,
        expireMonth: Failable<Int, MonthRange>,
        expireYear: Failable<Int, YearRange>,
        ccv2: Int?,
        firstName: String?,
        lastName: String?,
        billingAddress: Address?,
        customerID: Failable<String?, NotNilValidate<Length256>>
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
