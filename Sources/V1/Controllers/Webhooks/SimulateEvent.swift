import PayPal
import Vapor

extension Webhooks {
    
    /// The controller for the `/simulate-event` resource of the Webhooks PayPal API.
    public final class SimulateEvents: VersionedController {
        
        /// See `VersionedController.client`
        public let client: PayPalClient
        
        /// See `VersionedController.resource`.
        public let resource: [String]
        
        /// See `VersionedController.init(client:)`.
        public init(client: PayPalClient) {
            self.client = client
            self.resource = ["notifications", "simulate-event"]
        }
        
        /// Simulates a webhook event. In the JSON request body, specify a sample payload.
        ///
        /// A successful request returns the HTTP 202 Accepted status code and a JSON response body that
        /// shows details for the mock event.
        ///
        /// - Parameter event: The webhook event to simulate. This is the body of the request to PayPal.
        /// - Returns: The mocked `Event` object, wrapped in an `EventLoopFuture`.
        public func simulate(event: Event.Simulated) -> EventLoopFuture<Event> {
            return self.client.post(self.path, body: event, as: Event.self)
        }
    }
}
