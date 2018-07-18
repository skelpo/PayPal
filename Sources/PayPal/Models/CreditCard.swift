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
    public var expireMonth: Int
    
    /// The four-digit card expiry year, in `YYYY` format.
    public var expireYear: Int
    
    /// The card validation code. Supported only when making a payment but not when saving a credit card for future use.
    public var ccv2: Int?
    
    /// The first name of the card holder.
    public var firstName: String?
    
    /// The last name of the card holder.
    public var lastName: String?
    
    /// The billing address associated with this card.
    public var billingAddress: ShippingAddress?
    
    /// The facilitator-provided ID of the customer who owns this bank account.
    /// Required when storing a funding instrument or using a stored funding instrument in the PayPal vault.
    ///
    /// Maximum length: 256.
    public var customerID: String?
    
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
        billingAddress: ShippingAddress?,
        customerID: String?
    ) {
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
}
