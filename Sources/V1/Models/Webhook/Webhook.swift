import PayPal

/// The information for a webhook that will be fired by a PayPal action.
public struct Webhook: Codable {
    
    /// The ID of the webhook.
    public let id: String?
    
    /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/hateoas-links/).
    public let links: [LinkDescription]?
    
    /// The URL that is configured to listen on `localhost` for incoming `POST` notification messages
    /// that contain event information.
    public var url: String
    
    /// An array of events to which to subscribe your webhook. To subscribe to all events, including events as they are added,
    /// specify the asterisk wild card. To replace the `event_types` array, specify the asterisk wild card.  To list
    /// all supported events, [list available events](https://developer.paypal.com/docs/api/webhooks/v1/#event-type_list).
    public var events: [EventType]
    
    /// Creates a new `Webhook` instance.
    ///
    /// - Parameters:
    ///   - url: The URL that is configured to listen on `localhost` for incoming `POST` notification messages.
    ///   - events: An array of events to which to subscribe your webhook.
    public init(url: String, events: [EventType]) {
        self.id = nil
        self.links = nil
        
        self.url = url
        self.events = events
    }
    
    /// The entity types that `Webhook` objects can be filtered by when fetched from the PayPal API.
    public enum AnchorType: String, Hashable, CaseIterable, Codable {
        
        /// (Default) `APPLICATION`.
        case application = "APPLICATION"
        
        /// `ACCOUNT`.
        case account = "ACCOUNT"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, links, url
        case events = "event_types"
    }
}
