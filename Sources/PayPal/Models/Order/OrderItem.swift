import Vapor

extension Order {
    
    /// An item that a customer is purchasing from a merchant.
    public struct Item: Content, ValidationSetable, Equatable {
        
        /// The stock keeping unit (SKU) for the item.
        ///
        /// This property can be set with the `Item.set(_:)` method. This method
        /// verifies the new value before assigning it to the property
        ///
        /// Maximum length: 127.
        public private(set) var sku: String?
        
        /// The item name. If this value is greater than the maximum allowed length, the API truncates the string.
        ///
        /// This property can be set with the `Item.set(_:)` method. This method
        /// verifies the new value before assigning it to the property
        ///
        /// Maximum length: 127.
        public var name: String?
        
        /// The item description. Supported for only the PayPal payment method.
        ///
        /// This property can be set with the `Item.set(_:)` method. This method
        /// verifies the new value before assigning it to the property
        ///
        /// Maximum length: 127.
        public var description: String?
        
        /// The item quantity. Must be a whole number.
        ///
        /// This property can be set with the `Item.set(_:)` method. This method
        /// verifies the new value before assigning it to the property
        ///
        /// Maximum length: 10. Pattern: `^[0-9]{0,10}$`.
        public var quantity: String
        
        /// The item cost. Supports two decimal places.
        ///
        /// This property can be set with the `Item.set(_:)` method. This method
        /// verifies the new value before assigning it to the property
        ///
        /// Maximum length: 10. Pattern: `^[0-9]{0,10}(\.[0-9]{0,2})?$`.
        public var price: String
        
        /// The [three-character ISO-4217 currency code](https://developer.paypal.com/docs/integration/direct/rest/currency-codes/)
        /// that identifies the currency.
        public var currency: Currency
        
        /// The item tax. Supported only for the PayPal payment method.
        public var tax: String?
        
        
        /// Creates a new `Order.Item` instance.
        ///
        /// - Parameters:
        ///   - sku: The stock keeping unit (SKU) for the item.
        ///   - name: The item name.
        ///   - description: The item description.
        ///   - quantity: The item quantity.
        ///   - price: The item cost.
        ///   - currency: The currency code that identifies the currency.
        ///   - tax: The item tax.
        public init(
            sku: String?,
            name: String?,
            description: String?,
            quantity: String,
            price: String,
            currency: Currency,
            tax: String?
        ) {
            self.sku = sku
            self.name = name
            self.description = description
            self.quantity = quantity
            self.price = price
            self.currency = currency
            self.tax = tax
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Order.Item> {
            var validations = SetterValidations(Item.self)
            
            validations.set(\.sku) { sku in
                guard let sku = sku else { return }
                guard sku.count <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`sku` value must have a length of 127 or less")
                }
            }
            validations.set(\.name) { name in
                guard let name = name else { return }
                guard name.count <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`name` value must have a length of 127 or less")
                }
            }
            validations.set(\.description) { description in
                guard let description = description else { return }
                guard description.count <= 127 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`description` value must have a length of 127 or less")
                }
            }
            validations.set(\.quantity) { quantity in
                guard quantity.range(of: "^[0-9]{0,10}$", options: .regularExpression) != nil else {
                    throw PayPalError(
                        status: .badRequest, identifier: "malformedString", reason: "`quantity` value must match match RegEx pattern '^[0-9]{0,10}$'"
                    )
                }
            }
            validations.set(\.price) { price in
                guard price.range(of: "^[0-9]{0,10}$", options: .regularExpression) != nil else {
                    throw PayPalError(
                        status: .badRequest, identifier: "malformedString", reason: "`price` value must match match RegEx pattern '^[0-9]{0,10}(\\.[0-9]{0,2})?$'"
                    )
                }
            }
            
            
            return validations
        }
    }
}
