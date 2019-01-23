import Vapor

extension Invoice {
    
    /// A single item in an invoice.
    public struct Item: Content, Equatable {
        
        /// The item name.
        ///
        /// Maximum length: 200.
        public var name: Failable<String, Length200>
        
        /// The item description.
        ///
        /// Maximum length: 1000.
        public var description: Failable<String?, NotNilValidate<Length1000>>
        
        /// The item quantity. Value is from `-10,000` to `10,000`. Supports up to five decimal places.
        ///
        /// This property can be set using the `Item.set(_:)` method. This
        /// method will validate the new value before assigning it to the property.
        public var quantity: Failable<Decimal, TenThousand<Decimal>>
        
        /// The currency and amount of the item unit price. Value is from `-1,000,000` to `1,000,000`. Supports up to two decimal places.
        ///
        /// This property can be set using the `Item.set(_:)` method. This
        /// method will validate the new value before assigning it to the property.
        public var unitPrice: Failable<CurrencyAmount, CurrencyMillion<CurrencyKeys>>
        
        /// The tax information.
        public var tax: Tax?
        
        /// The date when the item or service was provided, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        /// For example, _yyyy-MM-dd z_.
        public var date: ISO8601Date?
        
        /// The item discount, as a percent or an amount value.
        public var discount: Discount<CurrencyAmount>?
        
        /// The unit of measure for the invoiced item. For `AMOUNT` the `unit_price` and `quantity` are not shown on the invoice.
        ///
        /// - Note: If your specify different `unit_of_measure` values for the same invoice, the invoice uses the first value.
        public var unitMeasure: Measure?
        
        
        /// Creates a new `Invoice.Item` instance.
        ///
        /// - Parameters:
        ///   - name: The item name.
        ///   - description: The item description.
        ///   - quantity: The item quantity.
        ///   - unitPrice: The currency and amount of the item unit price.
        ///   - tax: The tax information.
        ///   - date: The date when the item or service was provided, in Internet date and time format.
        ///   - discount: The item discount, as a percent or an amount value.
        ///   - unitMeasure: The unit of measure for the invoiced item.
        public init(
            name: Failable<String, Length200>,
            description: Failable<String?, NotNilValidate<Length1000>>,
            quantity: Failable<Decimal, TenThousand<Decimal>>,
            unitPrice: Failable<CurrencyAmount, CurrencyMillion<CurrencyKeys>>,
            tax: Tax?,
            date: Date?,
            discount: Discount<CurrencyAmount>?,
            unitMeasure: Measure?
        ) {
            self.name = name
            self.description = description
            self.quantity = quantity
            self.unitPrice = unitPrice
            self.tax = tax
            self.date = date == nil ? nil : ISO8601Date(date!)
            self.discount = discount
            self.unitMeasure = unitMeasure
        }
        
        enum CodingKeys: String, CodingKey {
            case name, description, quantity, tax, date, discount
            case unitPrice = "unit_price"
            case unitMeasure = "unit_of_measure"
        }
    }
}
