import Vapor

/// The merchant party of a customer dispute.
public struct Seller: Content, ValidationSetable, Equatable {
    
    /// The email address for the merchant's PayPal account.
    ///
    /// This property can be set using the `Buyer.set(_:)` method. This method
    /// will validate the new value before assigning it to the property.
    ///
    /// Minimum length: 3. Maximum length: 254.
    /// The values for this property must match the following RegEx pattern: `^.+@[^"\-].+$`.
    public private(set) var email: String?
    
    /// The PayPal account ID for the merchant.
    public var merchantID: String?
    
    /// The name of the merchant.
    public var name: String?
    
    
    /// Creates a new `Seller` instance.
    ///
    ///     Seller(email: "witheringheights@exmaple.com", name: "Leeli Wingfeather", merchantID: nil)
    public init(email: String?, name: String?, merchantID: String?)throws {
        self.email = email
        self.name = name
        self.merchantID = merchantID
        
        try self.set(\.email <~ email)
    }
    
    /// See [`Decoder.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let email = try container.decodeIfPresent(String.self, forKey: .email)
        
        self.email = email
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.merchantID = try container.decodeIfPresent(String.self, forKey: .merchantID)
        
        try self.set(\.email <~ email)
    }
    
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<Seller> {
        var validations = SetterValidations(Seller.self)
        
        validations.set(\.email) { email in
            guard let email = email else { return }
            guard let _ = email.range(of: "^.+@[^\"\\-].+$", options: .regularExpression) else {
                throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`email` property value must match '^.+@[^\"\\-].+$' RegEx pattern")
            }
            guard email.count >= 3 && email.count <= 254 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`email` property must have a length between 3 and 254")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case email, name
        case merchantID = "merchant_id"
    }
}

