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
        
        /// Shows details for an authorized payment, by ID.
        ///
        /// A successful request returns the HTTP 200 OK status code and a JSON response body that shows authorization details.
        ///
        /// - Parameter authorization: The ID of the authorized payment for which to show details.
        /// - Returns: The authorization details for the ID passed in.
        public func get(_ authorization: String) -> EventLoopFuture<Authorization> {
            return self.client.get(self.path + authorization, as: Authorization.self)
        }
    }
}
