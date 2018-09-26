import Vapor

extension Payment {
    
    /// An array of items that are being purchased in a PayPal payment.
    public struct ItemList: Content, ValidationSetable, Equatable {
        
        /// An array of items that are being purchased.
        public var items: [Item]?
        
        /// The shipping address details.
        public var address: Address?
        
        /// The shipping phone number, in its canonical international format as defined by the
        /// [E.164](https://en.wikipedia.org/wiki/E.164) numbering plan.
        ///
        /// Enables merchants to share payer’s contact number with PayPal for the current payment.
        /// The final contact number for the payer who is associated with the transaction might be
        /// the same as or different from the shipping_phone_number based on the payer’s action on PayPal.
        ///
        /// Minimum length: 1. Maximum length: 50.
        public var phoneNumber: String?
        
        /// Creates a new `Payment.ItemList` instance.
        ///
        /// - Parameters:
        ///   - items: An array of items that are being purchased.
        ///   - address: The shipping address details.
        ///   - phoneNumber: The shipping phone number, in its canonical international format as defined by the E.164 numbering plan.
        public init(items: [Item]?, address: Address?, phoneNumber: String?) {
            self.items = items
            self.address = address
            self.phoneNumber = phoneNumber
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Payment.ItemList> {
            var validations = SetterValidations(Payment.ItemList.self)
            
            validations.set(\.phoneNumber) { number in
                guard (1...50).contains(number?.count ?? 1) else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`phoneNumber` value length must be in range 1...50")
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case items
            case address = "shipping_address"
            case phoneNumber = "shipping_phone_number"
        }
    }
}
