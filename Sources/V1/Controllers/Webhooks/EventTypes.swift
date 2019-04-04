import PayPal
import Vapor

extension Webhooks {
    
    /// The controller for the `/webhooks-event-types` resource of the Webhooks PayPal API.
    public final class EventTypes: VersionedController {
        
        /// See `VersionedController.client`
        public let client: PayPalClient
        
        /// See `VersionedController.resource`.
        public let resource: [String]
        
        /// See `VersionedController.init(client:)`.
        public init(client: PayPalClient) {
            self.client = client
            self.resource = ["notifications", "webhooks-event-types"]
        }
        
        /// Lists available events to which any webhook can subscribe. For a list of supported events,
        /// see [Webhook event names](https://developer.paypal.com/docs/integration/direct/webhooks/event-names/).
        ///
        /// A successful request returns the HTTP 200 OK status code and a JSON response body that
        /// lists available events to which any webhook can subscribe.
        ///
        /// - Returns: The list of `EventType` objects, wrapped in an `EventLoopFuture`.
        public func list() -> EventLoopFuture<[EventType]> {
            return self.client.get("", as: [EventType].self)
        }
    }
}
