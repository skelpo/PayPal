import Vapor

extension Invoice {
    
    /// A single item in an invoice.
    public struct Item: Content, ValidationSetable, Equatable {
        
        /// The item name.
        ///
        /// This property can be set using the `Item.set(_:)` method. This
        /// method will validate the new value before assigning it to the property.
        ///
        /// Maximum length: 200.
        public private(set) var name: String
        
        /// The item description.
        ///
        /// This property can be set using the `Item.set(_:)` method. This
        /// method will validate the new value before assigning it to the property.
        ///
        /// Maximum length: 1000.
        public private(set) var description: String?
        
        /// The item quantity. Value is from `-10,000` to `10,000`. Supports up to five decimal places.
        ///
        /// This property can be set using the `Item.set(_:)` method. This
        /// method will validate the new value before assigning it to the property.
        public private(set) var quantity: Decimal
        
        /// The currency and amount of the item unit price. Value is from `-1,000,000` to `1,000,000`. Supports up to two decimal places.
        ///
        /// This property can be set using the `Item.set(_:)` method. This
        /// method will validate the new value before assigning it to the property.
        public private(set) var unitPrice: Amount
        
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
            unitPrice: Amount,
            tax: Tax?,
            date: String?,
            discount: Discount<Amount>?,
            unitMeasure: Measure?
        )throws {
            self.name = name
            self.description = description
            self.quantity = quantity
            self.unitPrice = unitPrice
            self.tax = tax
            self.date = date
            self.discount = discount
            self.unitMeasure = unitMeasure
            
            try self.set(\.name <~ name)
            try self.set(\.description <~ description)
            try self.set(\.quantity <~ quantity)
            try self.set(\.unitPrice <~ unitPrice)
        }
        
        /// See [`Decoder.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let name = try container.decode(String.self, forKey: .name)
            let description = try container.decodeIfPresent(String.self, forKey: .description)
            let quantity = try container.decode(Decimal.self, forKey: .quantity)
            let unitPrice = try container.decode(Amount.self, forKey: .unitPrice)
            
            self.name = name
            self.description = description
            self.quantity = quantity
            self.unitPrice = unitPrice
            self.tax = try container.decodeIfPresent(Tax.self, forKey: .tax)
            self.date = try container.decodeIfPresent(String.self, forKey: .date)
            self.discount = try container.decodeIfPresent(Discount<Amount>.self, forKey: .discount)
            self.unitMeasure = try container.decodeIfPresent(Measure.self, forKey: .unitPrice)
            
            try self.set(\.name <~ name)
            try self.set(\.description <~ description)
            try self.set(\.quantity <~ quantity)
            try self.set(\.unitPrice <~ unitPrice)
        }
        
        /// See `ValidationSetable.setterValidations()`.
        public func setterValidations() -> SetterValidations<Invoice.Item> {
            var validations = SetterValidations(Item.self)
            
            validations.set(\.name) { name in
                guard name.count <= 200 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`name` property must have a length between 0 and 200")
                }
            }
            validations.set(\.description) { description in
                if description == nil { return }
                guard description?.count ?? 0 <= 1000 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`description` property must have a length between 0 and 1000")
                }
            }
            validations.set(\.quantity) { quantity in
                guard quantity >= -10_000 && quantity <= 10_000 else {
                    throw PayPalError(status: .badRequest, identifier: "invalidLength", reason: "`quantity` property must have a length between -10,000 and 10,000")
                }
            }
            validations.set(\.unitPrice) { unitPrice in
                guard let price = Int(unitPrice.value) else { return }
                guard price >= -1_000_000 && price <= 1_000_000 else {
                    throw PayPalError(
                        status: .badRequest,
                        identifier: "invalidLength",
                        reason: "`unit_price` property must have a length between -1,000,000 and 1,000,000"
                    )
                }
            }
            
            return validations
        }
        
        enum CodingKeys: String, CodingKey {
            case name, description, quantity, tax, date, discount
            case unitPrice = "unit_price"
            case unitMeasure = "unit_of_measure"
        }
    }
}
