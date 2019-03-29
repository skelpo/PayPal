import Failable
import PayPal

extension Order {
    
    /// https://developer.paypal.com/docs/api/orders/v2/#definition-item
    public struct Item: Codable {
        
        /// The item name or title.
        public var name: Failable<String, NameLength>
        
        /// The item price or rate per unit. If you specify `unit_amount`, `purchase_units[].amount.breakdown.item_total`
        /// is required. Must equal `unit_amount * quantity` for all items.
        public var amount: CurrencyCodeAmount
        
        /// The item tax for each unit. If `tax` is specified, `purchase_units[].amount.breakdown.tax_total` is required.
        /// Must equal `tax * quantity` for all items.
        public var tax: CurrencyCodeAmount?
        
        /// The item quantity.
        public var quantity: Failable<Int, TenDigits<Int>>
        
        /// The detailed item description.
        public var description: Optional127String
        
        /// The stock keeping unit (SKU) for the item.
        public var sku: Optional127String
        
        /// The item category type.
        public var category: ItemCategory?
        
        /// Creates a new `Order.Item` instance.
        ///
        /// - Parameters:
        ///   - name: The item name or title.
        ///   - amount: The item price or rate per unit.
        ///   - tax: The item tax for each unit.
        ///   - quantity: The item quantity.
        ///   - description: The detailed item description.
        ///   - sku: The stock keeping unit (SKU) for the item.
        ///   - category: The item category type.
        public init(
            name: Failable<String, NameLength>,
            amount: CurrencyCodeAmount,
            tax: CurrencyCodeAmount?,
            quantity: Failable<Int, TenDigits<Int>>,
            description: Optional127String,
            sku: Optional127String,
            category: ItemCategory?
        ) {
            self.name = name
            self.amount = amount
            self.tax = tax
            self.quantity = quantity
            self.description = description
            self.sku = sku
            self.category = category
        }
        
        /// The validator for the `Order.Item.name` property value.
        public struct NameLength: LengthValidation {
            
            /// See `Validation.Supported`.
            public typealias Supported = String
            
            /// See `LengthValidation.minLength`.
            ///
            /// The minimum valid string length is 1.
            public static var minLength: Int = 1
            
            /// See `LengthValidation.maxLength`.
            ///
            /// The maximum valid string length is 127.
            public static var maxLength: Int = 127
        }
        
        enum CodingKeys: String, CodingKey {
            case name, tax, quantity, description, sku, category
            case amount = "unit_amount"
        }
    }
    
    public enum ItemCategory: String, Hashable, Codable, CaseIterable {
        
        /// Goods that are stored, delivered, and used in their electronic format.
        case digital = "DIGITAL_GOODS"
        
        /// A tangible item that can be shipped with proof of delivery.
        case physical = "PHYSICAL_GOODS"
    }
}
