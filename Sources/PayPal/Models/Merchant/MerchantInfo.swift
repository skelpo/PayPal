import Vapor

/// The information of a merchant in a business transaction.
public struct MerchantInfo: Content, Equatable {
    
    /// The merchant email address. This email must be listed in the merchant's PayPal profile.
    ///
    /// If you omit this value, notifications are sent from and to the primary email address but do not appear on the invoice.
    ///
    /// Maximum length: 260.
    public var email: Failable<String?, NotNilValidate<Length260>>
    
    /// The merchant's business name.
    ///
    /// Maximum length: 100.
    public var business: Failable<String?, NotNilValidate<Length100>>
    
    /// The merchant's first name.
    ///
    /// Maximum length: 256.
    public var firstName: Failable<String?, NotNilValidate<Length256>>
    
    /// The merchant's last name.
    ///
    /// Maximum length: 256.
    public var lastName: Failable<String?, NotNilValidate<Length256>>
    
    /// The merchant's address.
    public var address: Address?
    
    /// The merchant's phone number.
    public var phone: PhoneNumber?
    
    /// The merchant's fax number.
    public var fax: PhoneNumber?
    
    /// The merchant's website.
    ///
    /// Maximum length: 2048.
    public var website: Failable<String?, NotNilValidate<Length2048>>
    
    /// The merchant's tax ID.
    ///
    /// Maximum length: 100.
    public var taxID: Failable<String?, NotNilValidate<Length100>>
    
    /// Any additional information, such as business hours.
    ///
    /// Maximum length: 40.
    public var info: Failable<String?, NotNilValidate<Length40>>
    
    
    /// Creates a new `MerchantInfo` instance.
    ///
    /// - Parameters:
    ///   - email: The merchant email address. This email must be listed in the merchant's PayPal profile.
    ///   - business: The merchant's business name.
    ///   - firstName: The merchant's first name.
    ///   - lastName: The merchant's last name.
    ///   - address: The merchant's address.
    ///   - phone: The merchant's phone number.
    ///   - fax: The merchant's fax number.
    ///   - website: The merchant's website.
    ///   - taxID: The merchant's tax ID.
    ///   - info: Any additional information, such as business hours.
    public init(
        email: Failable<String?, NotNilValidate<Length260>>,
        business: Failable<String?, NotNilValidate<Length100>>,
        firstName: Failable<String?, NotNilValidate<Length256>>,
        lastName: Failable<String?, NotNilValidate<Length256>>,
        address: Address?,
        phone: PhoneNumber?,
        fax: PhoneNumber?,
        website: Failable<String?, NotNilValidate<Length2048>>,
        taxID: Failable<String?, NotNilValidate<Length100>>,
        info: Failable<String?, NotNilValidate<Length40>>
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
