import Vapor

/// The billing information for an invoice.
public struct BillingInfo: Content, Equatable {
    
    /// The invoice recipient email address. If you omit this value, the invoice is payable and a notification email is not sent.
    ///
    /// Maximum length: 260.
    public var email: Failable<String?, NotNilValidate<Length260>>
    
    /// The invoice recipient's phone number.
    public var phone: PhoneNumber?
    
    /// The invoice recipient's first name.
    ///
    /// Maximum length: 30.
    public var firstName: Failable<String?, NotNilValidate<Length30>>
    
    /// The invoice recipient's last name.
    ///
    /// Maximum length: 30.
    public var lastName: Failable<String?, NotNilValidate<Length30>>
    
    /// The invoice recipient's business name.
    ///
    /// Maximum length: 100.
    public var businessName: Failable<String?, NotNilValidate<Length100>>
    
    /// The invoice recipient's billing address.
    public var address: Address?
    
    /// The language in which the invoice recipient's email appears. Used only when the recipient does not have a PayPal account.
    ///
    /// If you omit the language and the recipient does not have a PayPal account, the email is sent in the language of the merchant's PayPal account.
    public var language: Language?
    
    /// Any additional information about the recipient.
    ///
    /// Maximum length: 40.
    public var info: Failable<String?, NotNilValidate<Length40>>
    
    
    /// Creates a new `BillingInfo` instance.
    ///
    /// - Parameters:
    ///   - email: The invoice recipient email address.
    ///   - phone: The invoice recipient's phone number.
    ///   - firstName: The invoice recipient's first name.
    ///   - lastName: The invoice recipient's last name.
    ///   - businessName: The invoice recipient's business name.
    ///   - address: The invoice recipient's billing address.
    ///   - language: The language in which the invoice recipient's email appears.
    ///   - info: Any additional information about the recipient.
    public init(
        email: Failable<String?, NotNilValidate<Length260>>,
        phone: PhoneNumber?,
        firstName: Failable<String?, NotNilValidate<Length30>>,
        lastName: Failable<String?, NotNilValidate<Length30>>,
        businessName: Failable<String?, NotNilValidate<Length100>>,
        address: Address?,
        language: Language?,
        info: Failable<String?, NotNilValidate<Length40>>
    ) {
        self.email = email
        self.phone = phone
        self.firstName = firstName
        self.lastName = lastName
        self.businessName = businessName
        self.address = address
        self.language = language
        self.info = info
    }
    
    enum CodingKeys: String, CodingKey {
        case email, phone, address, language
        case firstName = "first_name"
        case lastName = "last_name"
        case businessName = "business_name"
        case info = "additional_info"
    }
}
