import Vapor

/// The response object from PayPal's `GET /v1/customer/disputes` endpoint.
public struct CustomerDisputeList: Content, Equatable {
    
    /// An array of disputes that match a filter criteria. Sorted from latest to earliest creation time order.
    public var items: [CustomerDispute]?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
    public let links: [LinkDescription]?
    
    /// Creatse a new `CustomerDisputeList` instance.
    ///
    /// For the most part, you will never need this initializer.
    /// Rather, you will decode from JSON.
    public init(items: [CustomerDispute]) {
        self.items = items
        self.links = nil
    }
}
