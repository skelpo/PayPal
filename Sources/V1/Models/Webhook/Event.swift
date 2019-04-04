import PayPal

public struct Event: Codable {
    
    /// The ID of the webhook event notification.
    public let id: String?
    
    /// The date and time when the webhook event notification was created.
    public let created: ISO8601Date?
    
    /// The name of the resource related to the webhook notification event.
    public let resourceType: String?
    
    /// The event version in the webhook notification.
    public let version: EventType.Version?
    
    /// The event that triggered the webhook event notification.
    public let type: EventType.Name?
    
    /// A summary description for the event notification.
    public let summary: String?
    
    /// The resource version in the webhook notification.
    public let resourceVersion: EventType.Version?
    
    /// The resource that triggered the webhook event notification.
    public let resource: Resource?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/hateoas-links).
    public let links: [LinkDescription]?

    enum CodingKeys: String, CodingKey {
        case id, summary, resource, links
        case created = "create_time"
        case resourceType = "resource_type"
        case version = "event_version"
        case type = "event_type"
        case resourceVersion = "resource_version"
    }
}

public struct Resource: Codable {
    public let id: String?
    public let created: ISO8601Date?
    public let updated: ISO8601Date?
    public let state: String?
    public let amount: DetailedAmount?
    public let parent: String?
    public let validTo: ISO8601Date?
    
    enum CodingKeys: String, CodingKey {
        case id, state, amount
        case created = "create_time"
        case updated = "update_time"
        case parent = "parent_payment"
        case validTo = "valid_until"
    }
}
