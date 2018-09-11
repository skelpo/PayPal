import Vapor

public struct FinancialInstrument: Content, Equatable {
    public let type: String?
    public let accountType: String
    public var id: String?
    
    public init(id: String? = nil) {
        self.type = "BANK"
        self.id = id
        self.accountType = ""
    }
}
