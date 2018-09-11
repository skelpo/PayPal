import Vapor

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
    public var ccDescriptor: String?
    
    /// The name of the business that appears on the buyer’s bank or credit card statement. Supports only capital letters, numbers, spaces,
    /// and the `.`, `-`, and `*` special characters. Include one alphanumeric character with special characters.
    ///
    /// Minimum length: 2. Maximum length: 19.
    public var ccDescriptorExtended: String?
    
    
    /// Creates a new `PaymentReceivingPreferences` instance.
    ///
    /// All paramaters have default values of `nil`.
    ///
    ///     PaymentReceivingPreferences(
    ///         blockUnconfirmedUSAddress: true,
    ///         blockNonUS: false,
    ///         blockEcheck: false,
    ///         blockCrossCurrency: true,
    ///         blockSendMoney: false,
    ///         alternatePayment: "https://example.com/alternate"
    ///         displayInstructionsInput: true,
    ///         ccDescriptor: "NOT-SURE"
    ///         ccDescriptorExtended: "NOTE-SURE-AGAIN"
    ///     )
    public init(
        blockUnconfirmedUSAddress: Bool? = nil,
        blockNonUS: Bool? = nil,
        blockEcheck: Bool? = nil,
        blockCrossCurrency: Bool? = nil,
        blockSendMoney: Bool? = nil,
        alternatePayment: String? = nil,
        displayInstructionsInput: Bool? = nil,
        ccDescriptor: String? = nil,
        ccDescriptorExtended: String? = nil
    )throws {
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
}
