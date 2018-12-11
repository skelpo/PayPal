import Vapor

/// The shipping information for an invoice.
public struct ShippingInfo: Content, Equatable {
    
    /// The first name of the recipient of the shipped merchandise.
    ///
    /// Maximum length: 256.
    public var firstName: Failable<String?, NotNilValidate<Length256>>
    
    /// The last name of the recipient of the shipped merchandise.
    ///
    /// Maximum length: 256.
    public var lastName: Failable<String?, NotNilValidate<Length256>>
    
    /// The business name of the recipient of the shipped merchandise.
    ///
    /// Maximum length: 480.
    public var businessName: Failable<String?, NotNilValidate<Length480>>
    
    /// The address of the recipient of the shipped merchandise.
    public var address: Address?
    
    /// Creates a new `ShippingInfo` instance.
    ///
    /// - Parameters:
    ///   - firstName: The first name of the recipient of the shipped merchandise.
    ///   - lastName: The last name of the recipient of the shipped merchandise.
    ///   - businessName: The business name of the recipient of the shipped merchandise.
    ///   - address: The address of the recipient of the shipped merchandise.
    public init(
        firstName: Failable<String?, NotNilValidate<Length256>>,
        lastName: Failable<String?, NotNilValidate<Length256>>,
        businessName: Failable<String?, NotNilValidate<Length480>>,
        address: Address?
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.businessName = businessName
        self.address = address
    }
    
    enum CodingKeys: String, CodingKey {
        case address
        case firstName = "first_name"
        case lastName = "last_name"
        case businessName = "business_name"
    }
}
