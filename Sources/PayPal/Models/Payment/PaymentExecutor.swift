import Vapor

extension Payment {
    public struct Executor: Content, Equatable {
        public var payer: String?
        public var transactions: [DetailedAmount]?
        
        public init(payer: String?, transactions: [DetailedAmount]?) {
            self.payer = payer
            self.transactions = transactions
        }
    }
}
