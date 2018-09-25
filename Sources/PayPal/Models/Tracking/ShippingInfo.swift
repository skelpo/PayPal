import Vapor

/// The shipping information for an invoice.
public struct ShippingInfo: Content, ValidationSetable, Equatable {
    
    /// The first name of the recipient of the shipped merchandise.
    ///
    /// This property can be set using the `ShippingInfo.set(_:)` method. This
    /// method will validate the new value before assigning it to the property.
    ///
    /// Maximum length: 256.
    public var firstName: String?
    
    /// The last name of the recipient of the shipped merchandise.
    ///
    /// This property can be set using the `ShippingInfo.set(_:)` method. This
    /// method will validate the new value before assigning it to the property.
    ///
    /// Maximum length: 256.
    public var lastName: String?
    
    /// The business name of the recipient of the shipped merchandise.
    ///
    /// This property can be set using the `ShippingInfo.set(_:)` method. This
    /// method will validate the new value before assigning it to the property.
    ///
    /// Maximum length: 480.
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
    public init(firstName: String?, lastName: String?, businessName: String?, address: Address?)throws {
        self.firstName = firstName
        self.lastName = lastName
        self.businessName = businessName
        self.address = address
        
        try self.set(\.firstName <~ firstName)
        try self.set(\.lastName <~ lastName)
        try self.set(\.businessName <~ businessName)
    }
    
    /// See [`Decoder.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        try self.init(
            firstName: container.decodeIfPresent(String.self, forKey: .firstName),
            lastName: container.decodeIfPresent(String.self, forKey: .lastName),
            businessName: container.decodeIfPresent(String.self, forKey: .businessName),
            address: container.decodeIfPresent(Address.self, forKey: .address)
        )
    }
    
    /// See `ValidationSetable.setterValidations()`.
    public func setterValidations() -> SetterValidations<ShippingInfo> {
        var validations = SetterValidations(ShippingInfo.self)
        
        validations.set(\.firstName) { name in
            if name == nil { return }
            guard name?.count ?? 0 <= 256 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`first_name` property must have a length between 0 and 256")
            }
        }
        validations.set(\.lastName) { name in
            if name == nil { return }
            guard name?.count ?? 0 <= 256 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`last_name` property must have a length between 0 and 256")
            }
        }
        validations.set(\.businessName) { name in
            if name == nil { return }
            guard name?.count ?? 0 <= 480 else {
                throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`business_name` property must have a length between 0 and 256")
            }
        }
        
        return validations
    }
    
    enum CodingKeys: String, CodingKey {
        case address
        case firstName = "first_name"
        case lastName = "last_name"
        case businessName = "business_name"
    }
}
