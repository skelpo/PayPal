import Vapor

extension Payment {
    public struct Item: Content, Equatable {
        public var quantity: String
        public var price: String
        public var currency: Currency
        
        public var sku: String?
        public var name: String?
        public var description: String?
        public var tax: String?
        
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
