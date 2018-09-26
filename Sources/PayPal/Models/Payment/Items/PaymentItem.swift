import Vapor

extension Payment {
    
    /// An item that is being purchased with its parent payment.
    public struct Item: Content, Equatable {
        
        /// The item quantity. Must be a whole number.
        ///
        /// Maximum length: 10. Pattern: `^[0-9]{0,10}$`.
        public var quantity: String
        
        /// The item cost. Supports two decimal places.
        ///
        /// Maximum length: 10. Pattern: `^[0-9]{0,10}(\.[0-9]{0,2})?$`.
        public var price: String
        
        /// The [three-character ISO-4217 currency code](https://developer.paypal.com/docs/integration/direct/rest/currency-codes/)
        /// that identifies the currency.
        public var currency: Currency
        
        
        /// The stock keeping unit (SKU) for the item.
        ///
        /// Maximum length: 127.
        public var sku: String?
        
        /// The item name. If this value is greater than the maximum allowed length, the API truncates the string.
        ///
        /// Maximum length: 127.
        public var name: String?
        
        /// The item description. Supported for only the PayPal payment method.
        ///
        /// Maximum length: 127.
        public var description: String?
        
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
        ) {
            self.quantity = quantity
            self.price = price
            self.currency = currency
            self.sku = sku
            self.name = name
            self.description = description
            self.tax = tax
        }
    }
}
