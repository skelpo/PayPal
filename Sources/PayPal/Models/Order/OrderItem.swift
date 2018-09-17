import Vapor

extension Order {
    public struct Item: Content, Equatable {
        public var sku: String?
        public var name: String?
        public var description: String?
        public var quantity: String
        public var price: String
        public var currency: Currency
        public var tax: String?
        
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
