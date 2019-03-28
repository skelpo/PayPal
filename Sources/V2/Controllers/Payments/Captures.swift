import Vapor

extension Payments {
    
    /// The controller for the `/captures` resource of the Payments PayPal API.
    public final class Captures: VersionedController {
        
        /// See `VersionedController.client`
        public let client: PayPalClient
        
        /// See `VersionedController.resource`.
        public let resource: [String]
        
        /// See `VersionedController.init(client:)`.
        public init(client: PayPalClient) {
            self.client = client
            self.resource = ["payments", "captures"]
        }
    }
}
