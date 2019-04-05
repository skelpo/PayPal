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

    public struct Simulated: Codable {
        
        /// The ID of the webhook. If omitted, the URL is required.
        public var webhook: String?
        
        /// The URL for the webhook endpoint. If omitted, the webhook ID is required.
        public var url: String?
        
        /// The event name. Specify one of the subscribed events. For each request, provide only one event.
        public var type: EventType.Name
        
        /// The identifier for event type ex: 1.0/2.0 etc.
        public var version: EventType.Version?
        
        /// Creates a new `Event.Simulated` instance.
        ///
        /// - Parameters:
        ///   - webhook: The ID of the webhook. If omitted, the URL is required.
        ///   - url:  The URL for the webhook endpoint. If omitted, the webhook ID is required.
        ///   - type:  The event name. Specify one of the subscribed events.
        ///   - version: The identifier for event type ex: 1.0/2.0 etc.
        public init(webhook: String?, url: String?, type: EventType.Name, version: EventType.Version?) {
            self.webhook = webhook
            self.url = url
            self.type = type
            self.version = version
        }
        
        enum CodingKeys: String, CodingKey {
            case webhook = "webhook_id"
            case url
            case type = "event_type"
            case version = "resource_version"
        }
    }
    
    /// The response structure for a call to `Webhooks.Events.list(
    public struct List: Codable {
        
        /// An array of webhooks events.
        public var events: [Event]?
        
        /// The number of items in each range of results. Note that the response might have fewer items
        /// than the requested `page_size` value.
        public var count: Int?
        
        /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/overview/#hateoas-links).
        public let links: [LinkDescription]?
    }
    
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
