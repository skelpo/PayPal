import Failable

/// The recipient of the fee for a transaction.
public struct PayeeBase: Codable {
    
    /// The email address of merchant.
    public let email: Failable<String?, NotNilValidate<MerchantEmailValidation>>
    
    /// The encrypted PayPal account ID of the merchant.
    public let merchant: Failable<String?, NotNilValidate<MerchantIDValidation>>
    
    /// Creates a new `PayeeBase` instance.
    ///
    /// - Parameters:
    ///   - email: The email address of merchant.
    ///   - merchant: The encrypted PayPal account ID of the merchant.
    public init(
        email: Failable<String?, NotNilValidate<MerchantEmailValidation>>,
        merchant: Failable<String?, NotNilValidate<MerchantIDValidation>>
    ) {
        self.email = email
        self.merchant = merchant
    }
    
    enum CodingKeys: String, CodingKey {
        case email = "email_address"
        case merchant = "merchant_id"
    }
}

/// A validation for the `PayeeBase.email` property value.
public struct MerchantEmailValidation: RegexValidation {
    
    /// See `RegexValidation.pattern`.
    public static var pattern: String = #"(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*|(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"#
}

/// A validation for the `PayeeBase.merchant` property value.
public struct MerchantIDValidation: RegexValidation {
    
    /// See `RegexValidation.pattern`.
    public static var pattern: String = #"^[2-9A-HJ-NP-Z]{13}$"#
}
