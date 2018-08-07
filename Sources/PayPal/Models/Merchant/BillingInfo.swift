import Vapor

/// The billing information for an invoice.
public struct BillingInfo: Content, ValidationSetable, Equatable {
    
    /// The invoice recipient email address. If you omit this value, the invoice is payable and a notification email is not sent.
    ///
    /// This property can be set using the `BillingInfo.set(_:)` method, which
    /// will validate the new value before it is assigned to the property.
    ///
    /// Maximum length: 260.
    public private(set) var email: String?
    
    /// The invoice recipient's phone number.
    public var phone: PhoneNumber?
    
    /// The invoice recipient's first name.
    ///
    /// This property can be set using the `BillingInfo.set(_:)` method, which
    /// will validate the new value before it is assigned to the property.
    ///
    /// Maximum length: 30.
    public private(set) var firstName: String?
    
    /// The invoice recipient's last name.
    ///
    /// This property can be set using the `BillingInfo.set(_:)` method, which
    /// will validate the new value before it is assigned to the property.
    ///
    /// Maximum length: 30.
    public private(set) var lastName: String?
    
    /// The invoice recipient's business name.
    ///
    /// This property can be set using the `BillingInfo.set(_:)` method, which
    /// will validate the new value before it is assigned to the property.
    ///
    /// Maximum length: 100.
    public private(set) var businessName: String?
    
    /// The invoice recipient's billing address.
    public var address: Address?
    
    /// The language in which the invoice recipient's email appears. Used only when the recipient does not have a PayPal account.
    ///
    /// If you omit the language and the recipient does not have a PayPal account, the email is sent in the language of the merchant's PayPal account.
    public var language: Language?
    
    /// Any additional information about the recipient.
    ///
    /// This property can be set using the `BillingInfo.set(_:)` method, which
    /// will validate the new value before it is assigned to the property.
    ///
    /// Maximum length: 40.
    public private(set) var info: String?
    
    
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
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<BillingInfo> {
        var validations = SetterValidations(BillingInfo.self)
        
        validations.set(\.email) { email in
            guard email?.count ?? 0 <= 260 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`email` property must have a length of 260 or less")
            }
        }
        validations.set(\.firstName) { name in
            guard name?.count ?? 0 <= 30 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`first_name` property must have a length of 30 or less")
            }
        }
        validations.set(\.lastName) { name in
            guard name?.count ?? 0 <= 30 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`last_name` property must have a length of 30 or less")
            }
        }
        validations.set(\.businessName) { name in
            guard name?.count ?? 0 <= 100 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`business_name` property must have a length of 100 or less")
            }
        }
        validations.set(\.info) { info in
            guard info?.count ?? 0 <= 40 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`additional_info` property must have a length of 40 or less")
            }
        }
        
        return validations
    }
}
