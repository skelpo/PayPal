import Vapor

extension Payment {
    public struct Refund: Content, Equatable {
        public var amount: DetailedAmount?
        public var description: String?
        public var reason: String?
        public var invoice: String?
        
        public init(amount: DetailedAmount?, description: String?, reason: String?, invoice: String?) {
            self.amount = amount
            self.description = description
            self.reason = reason
            self.invoice = invoice
        }
        
        enum CodingKeys: String, CodingKey {
            case amount, description, reason
            case invoice = "invoice_number"
        }
    }
}
