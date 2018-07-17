import Vapor

/// Merchant preferances that override the default information for a billing agreement.
public struct MerchantPreferances: Content, ValidationSetable, Equatable {
    
    /// The PayPal-generated ID for the resource.
    ///
    /// Maximum length: 128.
    public let id: String?
    
    /// The currency and amount of the fee to set up the agreement. Default is `0`.
    public var setupFee: Money?
    
    /// The URL to which the customer is redirected if they cancel the agreement.
    ///
    /// This property can be set with the `MerchantPreferances.set(_:)` method,
    /// which will validate the new value before assigning it.
    ///
    /// Maximum length: 1000.
    public private(set) var cancelURL: String
    
    /// The URL to which the customer is redirected if they accept the agreement.
    ///
    /// This property can be set with the `MerchantPreferances.set(_:)` method,
    /// which will validate the new value before assigning it.
    ///
    /// Maximum length: 1000.
    public private(set) var returnURL: String
    
    /// The maximum number of allowed failed payment attempts.
    /// Default is `0`, which allows infinite failed payment attempts.
    public var maxFails: Int?
    
    /// Indicates whether PayPal automatically bills the outstanding balance
    /// in the next billing cycle. The outstanding balance is the total
    /// amount of any previously failed scheduled payments.
    public var autoBill: AutoBill?
    
    /// The action if the customer's initial payment fails.
    public var initialFailAction: InitialFailAction?
    
    /// The payment types that are accepted for this agreement. Read-only and reserved for future use.
    public let acceptedPaymentType: String?
    
    /// The character set for this agreement. Read-only and reserved for future use.
    public let charSet: String?
    
    /// Creates a new `MerchantPreferances` instance.
    ///
    ///     MerchantPreferances(
    ///         setupFee: Money(currency: .usd, value: "0"),
    ///         cancelURL: "https://example.com/agreements",
    ///         returnURL: "https://example.com/agreements/latest",
    ///         autoBill: .yes,
    ///         initialFailAction: .continue,
    ///         acceptedPaymentType: nil,
    ///         charSet: "UTF-8"
    ///     )
    public init(
        id: String? = nil,
        setupFee: Money?,
        cancelURL: String,
        returnURL: String,
        maxFails: Int? = 0,
        autoBill: AutoBill?,
        initialFailAction: InitialFailAction?,
        acceptedPaymentType: String?,
        charSet: String?
    )throws {
        guard id?.count ?? 0 < 128 else {
            throw PayPalError(identifier: "excededIDLength", reason: "ID length must be no greater then 128 characters")
        }
        
        self.id = id
        self.setupFee = setupFee
        self.cancelURL = cancelURL
        self.returnURL = returnURL
        self.maxFails = maxFails
        self.autoBill = autoBill
        self.initialFailAction = initialFailAction
        self.acceptedPaymentType = acceptedPaymentType
        self.charSet = charSet
        
        try self.set(\.cancelURL <~ cancelURL)
        try self.set(\.returnURL <~ returnURL)
    }
    
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            id: container.decodeIfPresent(String.self, forKey: .id),
            setupFee: container.decodeIfPresent(Money.self, forKey: .setupFee),
            cancelURL: container.decode(String.self, forKey: .cancelURL),
            returnURL: container.decode(String.self, forKey: .returnURL),
            maxFails: container.decodeIfPresent(Int.self, forKey: .maxFails),
            autoBill: container.decodeIfPresent(AutoBill.self, forKey: .autoBill),
            initialFailAction: container.decodeIfPresent(InitialFailAction.self, forKey: .initialFailAction),
            acceptedPaymentType: container.decodeIfPresent(String.self, forKey: .acceptedPaymentType),
            charSet: container.decodeIfPresent(String.self, forKey: .charSet)
        )
    }
    
    /// Compares two `MerchantPreferances` object, checking each property for equality.
    public static func == (lhs: MerchantPreferances, rhs: MerchantPreferances) -> Bool {
        return
            (lhs.id == rhs.id) &&
            (lhs.setupFee == rhs.setupFee) &&
            (lhs.cancelURL == rhs.cancelURL) &&
            (lhs.returnURL == rhs.returnURL) &&
            (lhs.maxFails == rhs.maxFails) &&
            (lhs.autoBill == rhs.autoBill) &&
            (lhs.initialFailAction == rhs.initialFailAction) &&
            (lhs.acceptedPaymentType == rhs.acceptedPaymentType) &&
            (lhs.charSet == rhs.charSet)
    }
    
    public static func setterValidations() -> SetterValidations<MerchantPreferances> {
        var validations = SetterValidations(MerchantPreferances.self)
        
        validations.set(\.cancelURL) { url in
            guard url.count <= 1000 else {
                throw PayPalError(status: .badRequest, identifier: "urlLengthExceded", reason: "URL length must be less then, or equal to, 1000")
            }
        }
        validations.set(\.returnURL) { url in
            guard url.count <= 1000 else {
                throw PayPalError(status: .badRequest, identifier: "urlLengthExceded", reason: "URL length must be less then, or equal to, 1000")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case setupFee = "setup_fee"
        case cancelURL = "cancel_url"
        case returnURL = "return_url"
        case maxFails = "max_fail_attempts"
        case autoBill = "auto_bill_amount"
        case initialFailAction = "initial_fail_amount_action"
        case acceptedPaymentType = "accepted_payment_type"
        case charSet = "char_set"
    }
}
