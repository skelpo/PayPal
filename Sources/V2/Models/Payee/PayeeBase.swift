import Failable

/// The recipient of the fee for a transaction.
public struct PayeeBase: Codable {
    
    /// The email address of merchant.
    public let email: Failable<String?, NotNilValidate<EmailValidation>>
    
    /// The encrypted PayPal account ID of the merchant.
    public let merchant: Failable<String?, NotNilValidate<IDValidation>>
    
    /// Creates a new `PayeeBase` instance.
    ///
    /// - Parameters:
    ///   - email: The email address of merchant.
    ///   - merchant: The encrypted PayPal account ID of the merchant.
    public init(
        email: Failable<String?, NotNilValidate<EmailValidation>>,
        merchant: Failable<String?, NotNilValidate<IDValidation>>
    ) {
        self.email = email
        self.merchant = merchant
    }
    
    enum CodingKeys: String, CodingKey {
        case email = "email_address"
        case merchant = "merchant_id"
    }
}
