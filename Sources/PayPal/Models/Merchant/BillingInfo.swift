import Vapor


/// The billing information for an invoice.
public struct BillingInfo: Content, Equatable {
    
    /// The invoice recipient email address. If you omit this value, the invoice is payable and a notification email is not sent.
    ///
    /// Maximum length: 260.
    public var email: String?
    
    /// The invoice recipient's phone number.
    public var phone: PhoneNumber?
    
    /// The invoice recipient's first name.
    ///
    /// Maximum length: 30.
    public var firstName: String?
    
    /// The invoice recipient's last name.
    ///
    /// Maximum length: 30.
    public var lastName: String?
    
    /// The invoice recipient's business name.
    ///
    /// Maximum length: 100.
    public var businessName: String?
    
    /// The invoice recipient's billing address.
    public var address: Address?
    
    /// The language in which the invoice recipient's email appears. Used only when the recipient does not have a PayPal account.
    ///
    /// If you omit the language and the recipient does not have a PayPal account, the email is sent in the language of the merchant's PayPal account.
    public var language: Language?
    
    /// Any additional information about the recipient.
    ///
    /// Maximum length: 40.
    public var info: String?
    
    
    /// Creates a new `BillingInfo` instance.
    ///
    ///     BillingInfo(
    ///         email: "ratigan@thirdceller.com",
    ///         phone: PhoneNumber(country: "1", number: "4586901518"),
    ///         firstName: "Padraic",
    ///         lastName: "Ratigan",
    ///         businessName: "Crime Lord",
    ///         address: Address(
    ///             recipientName: nil,
    ///             defaultAddress: true,
    ///             line1: "3rd Celler, Baker Street",
    ///             line2: nil,
    ///             city: "London",
    ///             state: nil,
    ///             countryCode: "UK",
    ///             postalCode: "42"
    ///         ),
    ///         language: .en_GB,
    ///         info: "For the captain."
    ///     )
    public init(
        email: String?,
        phone: PhoneNumber?,
        firstName: String?,
        lastName: String?,
        businessName: String?,
        address: Address?,
        language: Language?,
        info: String?
    )throws {
        self.email = email
        self.phone = phone
        self.firstName = firstName
        self.lastName = lastName
        self.businessName = businessName
        self.address = address
        self.language = language
        self.info = info
    }
}
