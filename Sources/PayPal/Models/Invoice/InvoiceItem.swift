import Vapor

extension Invoice {
    public struct Item: Content, Equatable {
        public var name: String
        public var description: String?
        public var quantity: Decimal
        public var unitPrice: Decimal
        public var tax: Tax?
        public var date: String?
        public var discount: Discount<Amount>?
        public var unitMeasure: Measure?
        
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
