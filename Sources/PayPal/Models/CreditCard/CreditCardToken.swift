import Vapor

extension CreditCard {
    public struct Token: Content, Equatable {
        public let suffix: String?
        public let type: String?
        public var expireMonth: Int?
        public var expiredYear: Int?
        
        public var creditCard: String
        public var payer: String?
        
        public init(creditCard: String, payer: String?) {
            self.suffix = nil
            self.type = nil
            self.expireMonth = nil
            self.expiredYear = nil
            
            self.creditCard = creditCard
            self.payer = payer
        }
    }
}
