import Vapor

/// The merchant party of a customer dispute.
public struct Seller: Content, Equatable {
    
    /// The email address for the merchant's PayPal account.
    ///
    /// Minimum length: 3. Maximum length: 254.
    /// The values for this property must match the following RegEx pattern: `^.+@[^"\-].+$`.
    public var email: Failable<String?, NotNilValidate<EmailString>>
    
    /// The PayPal account ID for the merchant.
    public var merchantID: String?
    
    /// The name of the merchant.
    public var name: String?
    
    
    /// Creates a new `Seller` instance.
    ///
    /// - Parameters:
    ///   - email: The email address for the merchant's PayPal account.
    ///   - name: The PayPal account ID for the merchant.
    ///   - merchantID: The name of the merchant.
    public init(email: Failable<String?, NotNilValidate<EmailString>>, name: String?, merchantID: String?) {
        self.email = email
        self.name = name
        self.merchantID = merchantID
    }
    
    enum CodingKeys: String, CodingKey {
        case email, name
        case merchantID = "merchant_id"
    }
}

