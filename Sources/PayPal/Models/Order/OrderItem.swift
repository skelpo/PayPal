import Vapor

extension Order {
    
    /// An item that a customer is purchasing from a merchant.
    public struct Item: Content, Equatable {
        
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
    }
}
