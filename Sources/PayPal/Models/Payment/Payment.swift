import Vapor

/// The payment data for a sale, authorized payment, or order.
public struct Payment: Content, ValidationSetable, Equatable {
    
    /// The ID of the payment.
    public let id: String?
    
    /// The state of the payment, authorization, or order transaction.
    public let state: State?
    
    /// The reason code for a payment failure.
    public let failure: Failure?
    
    /// The date and time when the payment was created, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let created: String?
    
    /// The date and time when the payment was updated, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
    public let updated: String?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    
    /// The payment intent.
    public var intent: Intent?
    
    /// The source of the funds for this payment. Payment method is PayPal Wallet payment or bank direct debit.
    public var payer: PaymentPayer?
    
    /// Use the application context resource to customize payment flow experience for your buyers.
    public var context: AppContext?
    
    /// An array of payment-related transactions. A transaction defines what the payment is for and who fulfills the payment.
    /// For update and execute payment calls, the `transactions` object accepts the `amount` object only.
    public var transactions: [Transaction]?
    
    /// The PayPal-generated ID for the merchant's payment experience profile. For information,
    /// see [create web experience profile](https://developer.paypal.com/docs/api/payment-experience/#web-profiles_create).
    public var experience: String?
    
    /// A free-form field that clients can use to send a note to the payer.
    ///
    /// This property can be set using the `Payment.set(_:)` method.
    /// This method validates the new value before assigning it to the property.
    ///
    /// Maximum length: 165.
    public private(set) var payerNote: String?
    
    /// A set of redirect URLs that you provide for PayPal-based payments.
    public var redirects: Redirects?
    
    
    /// Creates a new `Payment` instance.
    ///
    /// - Parameters:
    ///   - intent: The payment intent.
    ///   - payer: The source of the funds for this payment.
    ///   - context: Use the application context resource to customize payment flow experience for your buyers.
    ///   - transactions: An array of payment-related transactions.
    ///   - experience: The PayPal-generated ID for the merchant's payment experience profile.
    ///   - payerNote: A free-form field that clients can use to send a note to the payer.
    ///   - redirects: A set of redirect URLs that you provide for PayPal-based payments.
    public init(
       intent: Intent?,
       payer: PaymentPayer?,
       context: AppContext?,
       transactions: [Transaction]?,
       experience: String?,
       payerNote: String?,
       redirects: Redirects?
    )throws {
        self.id = nil
        self.state = nil
        self.failure = nil
        self.created = nil
        self.updated = nil
        self.links = nil
        
        self.intent = intent
        self.payer = payer
        self.context = context
        self.transactions = transactions
        self.experience = experience
        self.payerNote = payerNote
        self.redirects = redirects
        
        try self.set(\.payerNote <~ payerNote)
    }
    
    /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.state = try container.decodeIfPresent(State.self, forKey: .state)
        self.failure = try container.decodeIfPresent(Failure.self, forKey: .failure)
        self.created = try container.decodeIfPresent(String.self, forKey: .created)
        self.updated = try container.decodeIfPresent(String.self, forKey: .updated)
        self.links = try container.decodeIfPresent([LinkDescription].self, forKey: .links)
        self.intent = try container.decodeIfPresent(Intent.self, forKey: .intent)
        self.payer = try container.decodeIfPresent(PaymentPayer.self, forKey: .payer)
        self.context = try container.decodeIfPresent(AppContext.self, forKey: .context)
        self.transactions = try container.decodeIfPresent([Transaction].self, forKey: .transactions)
        self.experience = try container.decodeIfPresent(String.self, forKey: .experience)
        self.payerNote = try container.decodeIfPresent(String.self, forKey: .payerNote)
        self.redirects = try container.decodeIfPresent(Redirects.self, forKey: .redirects)
        
        try self.set(\.payerNote <~ payerNote)
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<Payment> {
        var validations = SetterValidations(Payment.self)
        
        validations.set(\.payerNote) { note in
            guard note?.count ?? 0 <= 165 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`note_to_payer` length must be 165 or less.")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case id, intent, payer, transactions, state, links
        case context = "application_context"
        case experience = "experience_profile_id"
        case payerNote = "note_to_payer"
        case redirects = "redirect_urls"
        case failure = "failure_reason"
        case created = "create_time"
        case updated = "update_time"
    }
}
