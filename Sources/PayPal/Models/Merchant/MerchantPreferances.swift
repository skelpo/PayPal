import Vapor

/// Merchant preferances that override the default information for a billing agreement.
public struct MerchantPreferances<M>: Content, Equatable where M: Amount {
    
    /// The PayPal-generated ID for the resource.
    ///
    /// Maximum length: 128.
    public let id: String?
    
    /// The currency and amount of the fee to set up the agreement. Default is `0`.
    public var setupFee: M?
    
    /// The URL to which the customer is redirected if they cancel the agreement.
    ///
    /// Maximum length: 1000.
    public var cancelURL: Failable<String, Length1000>
    
    /// The URL to which the customer is redirected if they accept the agreement.
    ///
    /// Maximum length: 1000.
    public var returnURL: Failable<String, Length1000>
    
    /// The maximum number of allowed failed payment attempts.
    /// Default is `0`, which allows infinite failed payment attempts.
    public var maxFails: String?
    
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
    /// - Parameters:
    ///   - setupFee: The currency and amount of the fee to set up the agreement.
    ///   - cancelURL: The URL to which the customer is redirected if they cancel the agreement.
    ///   - returnURL: The URL to which the customer is redirected if they accept the agreement.
    ///   - maxFails: The maximum number of allowed failed payment attempts.
    ///   - autoBill: Indicates whether PayPal automatically bills the outstanding balance in the next billing cycle.
    ///   - initialFailAction: The action if the customer's initial payment fails.
    ///   - acceptedPaymentType: The payment types that are accepted for this agreement.
    ///   - charSet: The character set for this agreement.
    public init(
        setupFee: M?,
        cancelURL: Failable<String, Length1000>,
        returnURL: Failable<String, Length1000>,
        maxFails: String? = "0",
        autoBill: AutoBill?,
        initialFailAction: InitialFailAction?,
        acceptedPaymentType: String?,
        charSet: String?
    ) {
        self.id = nil
        self.setupFee = setupFee
        self.cancelURL = cancelURL
        self.returnURL = returnURL
        self.maxFails = maxFails
        self.autoBill = autoBill
        self.initialFailAction = initialFailAction
        self.acceptedPaymentType = acceptedPaymentType
        self.charSet = charSet
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
