import Vapor

/// Merchant preferances that override the default information for a billing agreement.
public final class MerchantPreferances: Content, Equatable {
    
    /// The PayPal-generated ID for the resource.
    ///
    /// Maximum length: 128.
    public let id: String?
    
    /// The currency and amount of the fee to set up the agreement. Default is `0`.
    public var setupFee: Money?
    
    /// The URL to which the customer is redirected if they cancel the agreement.
    ///
    /// Maximum length: 1000.
    public var cancelURL: String
    
    /// The URL to which the customer is redirected if they accept the agreement.
    ///
    /// Maximum length: 1000.
    public var returnURL: String
    
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
    ) {
        self.id = id
        self.setupFee = setupFee
        self.cancelURL = cancelURL
        self.returnURL = returnURL
        self.maxFails = maxFails
        self.autoBill = autoBill
        self.initialFailAction = initialFailAction
        self.acceptedPaymentType = acceptedPaymentType
        self.charSet = charSet
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
}
