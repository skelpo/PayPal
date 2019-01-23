import Vapor

/// The validation for the `PaymentReceivingPreferences.ccDescriptor` property.
public struct CCDescriptor: LengthValidation {
    
    /// See `Validation.Supported`.
    public typealias Supported = String
    
    /// The string can be no more than 11 characters.
    public static var maxLength: Int = 11
    
    /// The string can be no less than 2 characters.
    public static var minLength: Int = 2
}

/// The validation for the `PaymentReceivingPreferences.ccDescriptorExtended` property.
public struct CCExtendedDescriptor: LengthValidation {
    
    /// See `Validation.Supported`.
    public typealias Supported = String
    
    /// The string can be no more than 19 characters.
    public static var maxLength: Int = 19
    
    /// The string can be no less than 2 characters.
    public static var minLength: Int = 2
}


/// Account preferences for the receipt of payments.
public struct PaymentReceivingPreferences: Content, Equatable {
    
    /// Indicates whether to block payments to this account from US buyers who do not provide a confirmed shipping address. To block, set to `TRUE`.
    public var blockUnconfirmedUSAddress: Bool?
    
    /// Indicates whether to block payments to this account from buyers who reside outside of the United States. To block, set to `TRUE`.
    public var blockNonUS: Bool?
    
    /// Indicates whether to block eCheck payments. To block, set to `TRUE`.
    public var blockEcheck: Bool?
    
    /// Indicates whether to block payments made in currencies that are not held by this account. To block, set to `TRUE`.
    public var blockCrossCurrency: Bool?
    
    /// Indicates whether to block payments to this account from the PayPal Send Money page. To block, set to `TRUE`.
    public var blockSendMoney: Bool?
    
    /// The alternative payments URL to use in place of the PayPal Send Money page. If you enable `block_send_money_payments`,
    /// specify an alternative payments URL to redirect a user who clicks **Send Money**.
    public var alternatePayment: String?
    
    /// Indicates whether to show the **Special instructions to merchant*** field during checkout,
    /// unless the field is suppressed through other means. To display special instructions, set to `TRUE`.
    public var displayInstructionsInput: Bool?
    
    /// The name of the campaign that appears on the buyer’s bank or credit card statement. Supports only capital letters, numbers, spaces,
    /// and the `.`, `-`, and `*` special characters. Include one alphanumeric character with special characters.
    ///
    /// Minimum length: 2. Maximum length: 11.
    public var ccDescriptor: Failable<String?, NotNilValidate<CCDescriptor>>
    
    /// The name of the business that appears on the buyer’s bank or credit card statement. Supports only capital letters, numbers, spaces,
    /// and the `.`, `-`, and `*` special characters. Include one alphanumeric character with special characters.
    ///
    /// Minimum length: 2. Maximum length: 19.
    public var ccDescriptorExtended: Failable<String?, NotNilValidate<CCExtendedDescriptor>>
    
    
    /// Creates a new `PaymentReceivingPreferences` instance.
    ///
    /// All paramaters have default values of `nil`.
    ///
    /// - Parameters:
    ///   - blockUnconfirmedUSAddress: Indicates whether to block payments from US buyers who do not provide a confirmed shipping address.
    ///   - blockNonUS: Indicates whether to block payments to this account from buyers who reside outside of the United States.
    ///   - blockEcheck: Indicates whether to block eCheck payments. To block, set to `TRUE`.
    ///   - blockCrossCurrency: Indicates whether to block payments made in currencies that are not held by this account.
    ///   - blockSendMoney: Indicates whether to block payments to this account from the PayPal Send Money page.
    ///   - alternatePayment: The alternative payments URL to use in place of the PayPal Send Money page.
    ///   - displayInstructionsInput: Indicates whether to show the **Special instructions to merchant*** field during checkout.
    ///   - ccDescriptor: The name of the campaign that appears on the buyer’s bank or credit card statement.
    ///   - ccDescriptorExtended: The name of the business that appears on the buyer’s bank or credit card statement.
    public init(
        blockUnconfirmedUSAddress: Bool? = nil,
        blockNonUS: Bool? = nil,
        blockEcheck: Bool? = nil,
        blockCrossCurrency: Bool? = nil,
        blockSendMoney: Bool? = nil,
        alternatePayment: String? = nil,
        displayInstructionsInput: Bool? = nil,
        ccDescriptor: Failable<String?, NotNilValidate<CCDescriptor>> = nil,
        ccDescriptorExtended: Failable<String?, NotNilValidate<CCExtendedDescriptor>> = nil
    ) {
        self.blockUnconfirmedUSAddress = blockUnconfirmedUSAddress
        self.blockNonUS = blockNonUS
        self.blockEcheck = blockEcheck
        self.blockCrossCurrency = blockCrossCurrency
        self.blockSendMoney = blockSendMoney
        self.alternatePayment = alternatePayment
        self.displayInstructionsInput = displayInstructionsInput
        self.ccDescriptor = ccDescriptor
        self.ccDescriptorExtended = ccDescriptorExtended
    }
    
    enum CodingKeys: String, CodingKey {
        case blockUnconfirmedUSAddress = "block_unconfirmed_us_address_payments"
        case blockNonUS = "block_non_us_payments"
        case blockEcheck = "block_echeck_payments"
        case blockCrossCurrency = "block_cross_currency_payments"
        case blockSendMoney = "block_send_money_payments"
        case alternatePayment = "alternate_payment_url"
        case displayInstructionsInput = "display_instructions_text_input"
        case ccDescriptor = "cc_soft_descriptor"
        case ccDescriptorExtended = "cc_soft_descriptor_extended"
    }
}
