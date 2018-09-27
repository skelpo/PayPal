import Vapor

public struct PaymentList: Content, Equatable {
    public let next: String?
    
    public var payments: [Payment]?
    public var count: Int?
}
