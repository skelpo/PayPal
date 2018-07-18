import Vapor

/// A user who funds a payment for a transaction.
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
    public var shippingAddress: ShippingAddress?
    
    /// The payer's billing address.
    public var billingAddress: ShippingAddress?
    
    /// Creates a new `Payer` instance.
    ///
    ///     Payer(
    ///         email: "payer@exmaple.com",
    ///         shippingAddress: nil,
    ///         billingAddress: ShippingAddress(
    ///             recipientName: "Puffin Billy",
    ///             defaultAddress: true,
    ///             line1: "89 Furnace Dr.",
    ///             line2: nil,
    ///             city: "Nowhere",
    ///             state: "KS",
    ///             countryCode: "US",
    ///             postalCode: "66167"
    ///         )
    ///     )
    public init(email: String?, shippingAddress: ShippingAddress?, billingAddress: ShippingAddress?) {
        self.id = nil
        self.firstName = nil
        self.lastName = nil
        
        self.email = email
        self.shippingAddress = shippingAddress
        self.billingAddress = billingAddress
    }
}
