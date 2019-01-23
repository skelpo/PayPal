import Vapor

/// Information about a user who funds a payment for a transaction.
public struct PayerInfo: Content, Equatable {
    
    /// The PayPal-assigned ID for the payer.
    public let id: String?
    
    /// The payer's first name.
    public let firstName: String?
    
    /// The payer's last name.
    public let lastName: String?
    
    /// The payer's email address.
    public var email: String?
    
    /// The shipping address for a payment. Must be provided if it differs from the default address.
    public var shippingAddress: Address?
    
    /// The payer's billing address.
    public var billingAddress: Address?
    
    /// Creates a new `PayerInfo` instance.
    ///
    /// - Parameters:
    ///   - email: The payer's email address.
    ///   - shippingAddress: The shipping address for a payment.
    ///   - billingAddress: The payer's billing address.
    public init(email: String?, shippingAddress: Address?, billingAddress: Address?) {
        self.id = nil
        self.firstName = nil
        self.lastName = nil
        
        self.email = email
        self.shippingAddress = shippingAddress
        self.billingAddress = billingAddress
    }
    
    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case shippingAddress = "shipping_address"
        case billingAddress = "billing_address"
    }
}
