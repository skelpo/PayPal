import Vapor

extension Payment {
    
    /// An item that is being purchased with its parent payment.
    public struct Item: Content, ValidationSetable, Equatable {
        
        /// The item quantity. Must be a whole number.
        ///
        /// This property can be set using the `Item.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 10. Pattern: `^[0-9]{0,10}$`.
        public private(set) var quantity: String
        
        /// The item cost. Supports two decimal places.
        ///
        /// This property can be set using the `Item.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 10. Pattern: `^[0-9]{0,10}(\.[0-9]{0,2})?$`.
        public private(set) var price: String
        
        /// The [three-character ISO-4217 currency code](https://developer.paypal.com/docs/integration/direct/rest/currency-codes/)
        /// that identifies the currency.
        public var currency: Currency
        
        
        /// The stock keeping unit (SKU) for the item.
        ///
        /// This property can be set using the `Item.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 127.
        public private(set) var sku: String?
        
        /// The item name. If this value is greater than the maximum allowed length, the API truncates the string.
        ///
        /// This property can be set using the `Item.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 127.
        public private(set) var name: String?
        
        /// The item description. Supported for only the PayPal payment method.
        ///
        /// This property can be set using the `Item.set(_:)` method.
        /// This method validates the new value before assigning it to the property.
        ///
        /// Maximum length: 127.
        public private(set) var description: String?
        
        /// The item tax. Supported only for the PayPal payment method.
        public var tax: String?
        
        
        /// Creates a new `Payment.Item` instance.
        ///
        /// - Parameters:
        ///   - quantity: The item quantity.
        ///   - price: The item cost.
        ///   - currency: The three-character ISO-4217 currency cod
        ///   - sku: The stock keeping unit (SKU) for the item.
        ///   - name: The item name.
        ///   - description: The item description.
        ///   - tax: The item tax.
        public init(
            quantity: String,
            price: String,
            currency: Currency,
            sku: String?,
            name: String?,
            description: String?,
            tax: String?
        )throws {
            self.quantity = quantity
            self.price = price
            self.currency = currency
            self.sku = sku
            self.name = name
            self.description = description
            self.tax = tax
            
            try self.set(\.quantity <~ quantity)
            try self.set(\.price <~ price)
            try self.set(\.sku <~ sku)
            try self.set(\.name <~ name)
            try self.set(\.description <~ description)
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            try self.init(
                quantity: container.decode(String.self, forKey: .quantity),
                price: container.decode(String.self, forKey: .price),
                currency: container.decode(Currency.self, forKey: .currency),
                sku: container.decodeIfPresent(String.self, forKey: .sku),
                name: container.decodeIfPresent(String.self, forKey: .name),
                description: container.decodeIfPresent(String.self, forKey: .description),
                tax: container.decodeIfPresent(String.self, forKey: .tax))
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Payment.Item> {
            var validations = SetterValidations(Payment.Item.self)
            
            validations.set(\.quantity) { quantity in
                let regex = "^[0-9]{0,10}$"
                guard quantity.range(of: regex, options: .regularExpression) != nil else {
                    throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`quantity` must match RegEx pattern `\(regex)`")
                }
            }
            validations.set(\.price) { price in
                let regex = "^[0-9]{0,10}(\\.[0-9]{0,2})?$"
                guard price.count <= 10 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`price` value must have a length of 10 or less")
                }
                guard price.range(of: regex, options: .regularExpression) != nil else {
                    throw PayPalError(status: .badRequest, identifier: "malformedString", reason: "`price` must match RegEx pattern `\(regex)`")
                }
            }
            validations.set(\.sku) { sku in
                guard sku?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`sku` value must have a length of 127 or less")
                }
            }
            validations.set(\.name) { name in
                guard name?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`name` value must have a length of 127 or less")
                }
            }
            validations.set(\.description) { description in
                guard description?.count ?? 0 <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`description` value length must be 127 or less")
                }
            }
            
            return validations
        }
    }
}
