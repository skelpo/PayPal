import Vapor

public struct Payer: Content, Equatable {
    public let fundingOption: String?
    
    public var method: PaymentMethod
    public var fundingInstruments: [CreditCard]?
    public var info: PayerInfo?
    
    public init(method: PaymentMethod, fundingInstruments: [CreditCard]?, info: PayerInfo?) {
        self.fundingOption = nil
        self.method = method
        self.fundingInstruments = fundingInstruments
        self.info = info
    }
}
