import Vapor

public struct BalanceResponse: Content, Equatable {
    public let payer: String?
    public var available: Money?
    public var pending: Money?
}
