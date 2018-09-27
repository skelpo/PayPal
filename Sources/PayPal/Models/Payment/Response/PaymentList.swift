import Vapor

/// The response returned from the `GET /v1/payments/payment` API endpoint.
public struct PaymentList: Content, Equatable {
    
    /// The ID of the element to use to get the next range of results.
    public let next: String?
    
    
    /// An array of payments.
    public var payments: [Payment]?
    
    /// The number of items returned in each range of results. Note that the last
    /// results range might have fewer items than the requested number of items.
    ///
    /// Maximum value: 20.
    public var count: Int?
    
    enum CodingKeys: String, CodingKey {
        case payments, count
        case next = "next_id"
    }
}
