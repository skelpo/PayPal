import PayPal
import Vapor

extension Webhooks {
    
    /// The controller for the `/webhooks-events` resource of the Webhooks PayPal API.
    public final class Events: VersionedController {
        
        /// See `VersionedController.client`
        public let client: PayPalClient
        
        /// See `VersionedController.resource`.
        public let resource: [String]
        
        /// See `VersionedController.init(client:)`.
        public init(client: PayPalClient) {
            self.client = client
            self.resource = ["notifications", "webhooks-events"]
        }
    }
}

