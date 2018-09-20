import Vapor

/// An order for products, sold by a merchant, to a client.
public struct Order: Content, Equatable {
    
    /// The ID of the order.
    public let id: String?
    
    /// The status of the order. After the customer approves the order, the status is `APPROVED`. After the payment is made for the order and the order completes, the status is `COMPLETED`.
    public let status: Status?
    
    /// The date and time when the resource was created, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let created: String?
    
    /// The date and time when the resource was last updated, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6)
    public let updated: String?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    /// To complete the buyer approval, use the `approval_url` link with the `GET` method and do not use the link that shows the `REDIRECT` method.
    public let links: [LinkDescription]?
    
    
    /// The intent.
    public var intent: Intent?
    
    /// An array of purchase units. Each purchase unit establishes a contract between a customer and merchant.
    public var units: [Unit]?
    
    /// The payment details for the order.
    public var payment: Payment?
    
    /// The currency and amount of the PayPal-computed total of amounts in all purchase units.
    public var total: Amount?
    
    /// Customizes the payer experience during the approval process for the payment with PayPal.
    public var context: AppContext?
    
    /// The name-and-value pairs that contain external data, such as user, user feedback, score, and so on.
    public var metadata: Metadata?
    
    /// The redirect URLs. Required only for the PayPal payment method. The supported settings are return and cancel URLs.
    public var redirects: Redirects?
    
    
    /// Creates a new `Order` instance.
    ///
    /// - Parameters:
    ///   - intent: The intent.
    ///   - units: An array of purchase units.
    ///   - payment: The payment details for the order.
    ///   - total: The currency and amount of the PayPal-computed total of amounts in all purchase units.
    ///   - context: Customizes the payer experience during the approval process for the payment with PayPal.
    ///   - metadata: The name-and-value pairs that contain external data.
    ///   - redirects: The redirect URLs.
    public init(
        intent: Intent?,
        units: [Unit]?,
        payment: Payment?,
        total: Amount?,
        context: AppContext?,
        metadata: Metadata?,
        redirects: Redirects?
    ) {
        self.id = nil
        self.status = nil
        self.created = nil
        self.updated = nil
        self.links = nil
        
        self.intent = intent
        self.units = units
        self.payment = payment
        self.total = total
        self.context = context
        self.metadata = metadata
        self.redirects = redirects
    }
}
