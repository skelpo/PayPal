import Vapor

/// The information of a merchant in a business transaction.
public struct MerchantInfo: Content, Equatable {
    
    /// The merchant email address. This email must be listed in the merchant's PayPal profile.
    ///
    /// If you omit this value, notifications are sent from and to the primary email address but do not appear on the invoice.
    ///
    /// Maximum length: 260.
    public var email: String?
    
    /// The merchant's business name.
    ///
    /// Maximum length: 100.
    public var business: String?
    
    /// The merchant's first name.
    ///
    /// Maximum length: 256.
    public var firstName: String?
    
    /// The merchant's last name.
    ///
    /// Maximum length: 256.
    public var lastName: String?
    
    /// The merchant's address.
    public var address: Address?
    
    /// The merchant's phone number.
    public var phone: PhoneNumber?
    
    /// The merchant's fax number.
    public var fax: PhoneNumber?
    
    /// The merchant's website.
    ///
    /// Maximum length: 2048.
    public var website: String?
    
    /// The merchant's tax ID.
    ///
    /// Maximum length: 100.
    public var taxID: String?
    
    /// Any additional information, such as business hours.
    ///
    /// Maximum length: 40.
    public var info: String?
    
    
    /// Creates a new `MerchantInfo` instance.
    ///
    ///     MerchantInfo(
    ///         email: "basil@baker.com",
    ///         business: "Basil Cases and Mystery",
    ///         firstName: "Basil",
    ///         lastName: "Mouse",
    ///          address: Address(
    ///             recipientName: nil,
    ///             defaultAddress: true,
    ///             line1: "221B Baker Street",
    ///             line2: nil,
    ///             city: "London",
    ///             state: nil,
    ///             countryCode: "UK",
    ///             postalCode: "42"
    ///         ),
    ///         phone: PhoneNumber(country: "1", number: "9963191901"),
    ///         fax: PhoneNumber(country: "1", number: "9963191901"),
    ///         website: nil,
    ///         taxID: "934-00-2376",
    ///         info: "He sells cheese. Rich cheese."
    ///     )
    public init(
        email: String?,
        business: String?,
        firstName: String?,
        lastName: String?,
        address: Address?,
        phone: PhoneNumber?,
        fax: PhoneNumber?,
        website: String?,
        taxID: String?,
        info: String?
    )throws {
        self.email = email
        self.business = business
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.phone = phone
        self.fax = fax
        self.website = website
        self.taxID = taxID
        self.info = info
    }
    
    enum CodingKeys: String, CodingKey {
        case email, address, phone, fax, website
        case business = "business_name"
        case firstName = "first_name"
        case lastName = "last_name"
        case taxID = "tax_id"
        case info = "additional_info"
    }
}
