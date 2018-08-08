import Vapor

/// The shipping information for an invoice.
public struct ShippingInfo: Content, Equatable {
    
    /// The first name of the recipient of the shipped merchandise.
    public var firstName: String?
    
    /// The last name of the recipient of the shipped merchandise.
    public var lastName: String?
    
    /// The business name of the recipient of the shipped merchandise.
    public var businessName: String?
    
    /// The address of the recipient of the shipped merchandise.
    public var address: Address?
    
    /// Creates a new `ShippingInfo` instance.
    ///
    ///     ShippingInfo(
    ///         firstName: "Oskar",
    ///         lastName: "Reteep",
    ///         businessName: "Books and Crannies",
    ///         address: Address(
    ///             recipientName: "Oskar Reteep",
    ///             defaultAddress: true,
    ///             line1: "1 Main Street",
    ///             line2: nil,
    ///             city: "Glipwood",
    ///             state: nil,
    ///             countryCode: "SK",
    ///             postalCode: "562"
    ///         )
    ///     )
    public init(firstName: String?, lastName: String?, businessName: String?, address: Address?) {
        self.firstName = firstName
        self.lastName = lastName
        self.businessName = businessName
        self.address = address
    }
}
