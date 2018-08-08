import Vapor

extension Invoice {
    
    /// A single item in an invoice.
    public struct Item: Content, Equatable {
        
        /// The item name.
        ///
        /// Maximum length: 200.
        public var name: String
        
        /// The item description.
        ///
        /// Maximum length: 1000.
        public var description: String?
        
        /// The item quantity. Value is from `-10000` to `10000`. Supports up to five decimal places.
        public var quantity: Decimal
        
        /// The currency and amount of the item unit price. Value is from `-1000000` to `1000000`. Supports up to two decimal places.
        public var unitPrice: Decimal
        
        /// The tax information.
        public var tax: Tax?
        
        /// The date when the item or service was provided, in [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
        /// For example, _yyyy-MM-dd z_.
        public var date: String?
        
        /// The item discount, as a percent or an amount value.
        public var discount: Discount<Amount>?
        
        /// The unit of measure for the invoiced item. For `AMOUNT` the `unit_price` and `quantity` are not shown on the invoice.
        ///
        /// - Note: If your specify different `unit_of_measure` values for the same invoice, the invoice uses the first value.
        public var unitMeasure: Measure?
        
        
        /// Creates a new `Invoice.Item` instance.
        ///
        ///     Invoice.Item(
        ///         name: "Widget",
        ///         description: "Round and white, like a ping-pong ball",
        ///         quantity: 3,
        ///         unitPrice: 50,
        ///         tax: Tax(name: "Sales", percent: 10, amount: Amount(currency: .usd, value: "5.00")),
        ///         date: Date().iso8601,
        ///         discount: nil,
        ///         unitMeasure: .quantity
        ///     )
        public init(
            name: String,
            description: String?,
            quantity: Decimal,
            unitPrice: Decimal,
            tax: Tax?,
            date: String?,
            discount: Discount<Amount>?,
            unitMeasure: Measure?
        ) {
            self.name = name
            self.description = description
            self.quantity = quantity
            self.unitPrice = unitPrice
            self.tax = tax
            self.date = date
            self.discount = discount
            self.unitMeasure = unitMeasure
        }
    }
}
