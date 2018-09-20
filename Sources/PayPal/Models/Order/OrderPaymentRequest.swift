import Vapor

extension Order {
    public struct PaymentRequest: Content, Equatable {
        public var disbursement: DisbursementMode
        public var payer: Payer?
        
        public init(disbursement: DisbursementMode, payer: Payer?) {
            self.disbursement = disbursement
            self.payer = payer
        }
    }
}
