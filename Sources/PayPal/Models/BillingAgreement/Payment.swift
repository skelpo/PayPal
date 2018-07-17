import Vapor

public struct Payment: Content, Equatable {
    public let id: String?
    public var name: String
    public var type: PaymentType
    public var interval: String
    public var frequency: Frequency
    public var cycles: String
    public var amount: Money
    public var charges: [Charge]?
    
    public init(name: String, type: PaymentType, interval: String, frequency: Frequency, cycles: String, amount: Money, charges: [Charge]?) {
        self.id = nil
        self.name = name
        self.type = type
        self.interval = interval
        self.frequency = frequency
        self.cycles = cycles
        self.amount = amount
        self.charges = charges
    }
}
