import Vapor

/// The length range validation for the `Payment.List.phoneNumber` property.
public struct PhoneNumberLength: LengthValidation {
    
    /// See `Validation.Supported`.
    public typealias Supported = String
    
    /// The phone number string must have 50 or less characters.
    public static var maxLength: Int = 50
    
    /// The phone number string must have 1 or more characters.
    public static var minLength: Int = 1
}

extension Payment {
    
    /// An array of items that are being purchased in a PayPal payment.
    public struct ItemList: Content, Equatable {
        
        /// An array of items that are being purchased.
        public var items: [Item]?
        
        /// The shipping address details.
        public var address: Address?
        
        /// The shipping phone number, in its canonical international format as defined by the
        /// [E.164](https://en.wikipedia.org/wiki/E.164) numbering plan.
        ///
        /// Minimum length: 1. Maximum length: 50.
        public var phoneNumber: Failable<String?, NotNilValidate<PhoneNumberLength>>
        
        /// Creates a new `Payment.ItemList` instance.
        ///
        /// - Parameters:
        ///   - items: An array of items that are being purchased.
        ///   - address: The shipping address details.
        ///   - phoneNumber: The shipping phone number, in its canonical international format as defined by the E.164 numbering plan.
        public init(items: [Item]?, address: Address?, phoneNumber: Failable<String?, NotNilValidate<PhoneNumberLength>>) {
            self.items = items
            self.address = address
            self.phoneNumber = phoneNumber
        }
        
        enum CodingKeys: String, CodingKey {
            case items
            case address = "shipping_address"
            case phoneNumber = "shipping_phone_number"
        }
    }
}
