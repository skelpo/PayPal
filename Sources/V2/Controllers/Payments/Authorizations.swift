import Vapor

extension Payments {
    
    /// The controller for the `/authorizations` resource of the Payments PayPal API.
    public final class Authorizations: VersionedController {
        
        /// See `VersionedController.client`
        public let client: PayPalClient
        
        /// See `VersionedController.resource`.
        public let resource: [String]
        
        /// See `VersionedController.init(client:)`.
        public init(client: PayPalClient) {
            self.client = client
            self.resource = ["payments", "authorizations"]
        }
    }
}
