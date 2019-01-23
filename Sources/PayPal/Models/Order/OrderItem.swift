import Vapor

extension Order {
    
    /// An item that a customer is purchasing from a merchant.
    public struct Item: Content, Equatable {
        
        /// The stock keeping unit (SKU) for the item.
        ///
        /// Maximum length: 127.
        public var sku: Optional127String
        
        /// The item name. If this value is greater than the maximum allowed length, the API truncates the string.
        ///
        /// Maximum length: 127.
        public var name: Optional127String
        
        /// The item description. Supported for only the PayPal payment method.
        ///
        /// Maximum length: 127.
        public var description: Optional127String
        
        /// The item quantity. Must be a whole number.
        ///
        /// Maximum length: 10. Pattern: `^[0-9]{0,10}$`.
        public var quantity: Failable<Int, TenDigits<Int>>
        
        /// The item cost. Supports two decimal places.
        ///
        /// Maximum length: 10. Pattern: `^[0-9]{0,10}(\.[0-9]{0,2})?$`.
        public var price: Failable<Decimal, TenDigits<Decimal>>
        
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
            sku: Optional127String,
            name: Optional127String,
            description: Optional127String,
            quantity: Failable<Int, TenDigits<Int>>,
            price: Failable<Decimal, TenDigits<Decimal>>,
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
        
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: Order.Item.CodingKeys.self)
            
            let quantity: Int
            do {
                quantity = try container.decode(Int.self, forKey: .quantity)
            } catch let error as DecodingError {
                guard case DecodingError.typeMismatch(_, _) = error else { throw error }
                guard let value = try Int(container.decode(String.self, forKey: .quantity)) else {
                    throw DecodingError.dataCorruptedError(forKey: .quantity, in: container, debugDescription: "Cannot get int from given string")
                }
                quantity = value
            }
            
            guard let price = try Decimal(string: container.decode(String.self, forKey: .price)) else {
                throw DecodingError.dataCorruptedError(forKey: .price, in: container, debugDescription: "Cannot get decimal from given string")
            }
            
            self.price = try price.failable()
            self.quantity = try quantity.failable()
            self.sku = try container.decode(Optional127String.self, forKey: .sku)
            self.name = try container.decode(Optional127String.self, forKey: .name)
            self.description = try container.decode(Optional127String.self, forKey: .description)
            self.currency = try container.decode(Currency.self, forKey: .currency)
            self.tax = try container.decodeIfPresent(String.self, forKey: .tax)
        }
        
        public func encode(to encoder: Encoder)throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            var price = self.price.value
            var encodePrice = self.price.value
            NSDecimalRound(&encodePrice, &price, 2, .bankers)
            
            try container.encode(self.sku, forKey: .sku)
            try container.encode(self.name, forKey: .name)
            try container.encode(self.description, forKey: .description)
            try container.encode(self.quantity.value.description, forKey: .quantity)
            try container.encode(encodePrice.description, forKey: .price)
            try container.encode(self.currency, forKey: .currency)
            try container.encodeIfPresent(self.tax, forKey: .tax)
        }
        
        enum CodingKeys: String, CodingKey {
            case sku
            case name
            case description
            case quantity
            case price
            case currency
            case tax
        }
    }
}
