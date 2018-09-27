import Vapor

public struct PaymentList: Content, Equatable {
    public let next: String?
    
    public var payments: [Payment]?
    public var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case payments, count
        case next = "next_id"
    }
}
