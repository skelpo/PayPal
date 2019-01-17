import Vapor

extension Payment {
    
    /// An item that is being purchased with its parent payment.
    public struct Item: Content, Equatable {
        
        /// The item quantity.
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
            quantity: Failable<Int, TenDigits<Int>>,
            price: Failable<Decimal, TenDigits<Decimal>>,
            currency: Currency,
            sku: Optional127String,
            name: Optional127String,
            description: Optional127String,
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
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: Payment.Item.CodingKeys.self)
         
            let strInt = try container.decode(String.self, forKey: .quantity)
            let strDec = try container.decode(String.self, forKey: .price)
            guard let quantity = Int(strInt) else {
                throw DecodingError.dataCorruptedError(forKey: .quantity, in: container, debugDescription: "String not convertible to int")
            }
            guard let price = Decimal(string: strDec) else {
                throw DecodingError.dataCorruptedError(forKey: .price, in: container, debugDescription: "String not convertible to decimal")
            }
            
            self.quantity = try quantity.failable()
            self.price = try price.failable()
            self.currency = try container.decode(Currency.self, forKey: .currency)
            self.sku = try container.decode(Optional127String.self, forKey: .sku)
            self.name = try container.decode(Optional127String.self, forKey: .name)
            self.description = try container.decode(Optional127String.self, forKey: .description)
            self.tax = try container.decodeIfPresent(String.self, forKey: .tax)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(String(describing: self.quantity), forKey: .quantity)
            try container.encode(String(describing: self.price), forKey: .price)
            try container.encode(self.currency, forKey: .currency)
            try container.encode(self.sku, forKey: .sku)
            try container.encode(self.name, forKey: .name)
            try container.encode(self.description, forKey: .description)
            try container.encodeIfPresent(self.tax, forKey: .tax)
        }
        
        
        enum CodingKeys: String, CodingKey {
            case quantity, price, currency, sku, name, description, tax
        }
    }
}
