import Vapor

extension Payments {
    
    /// The controller for the `/refunds` resource of the Payments PayPal API.
    public final class Refunds: VersionedController {
        
        /// See `VersionedController.client`
        public let client: PayPalClient
        
        /// See `VersionedController.resource`.
        public let resource: [String]
        
        /// See `VersionedController.init(client:)`.
        public init(client: PayPalClient) {
            self.client = client
            self.resource = ["payments", "refunds"]
        }
    }
}
