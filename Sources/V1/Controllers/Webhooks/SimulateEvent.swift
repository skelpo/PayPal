import PayPal

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
    }
}
