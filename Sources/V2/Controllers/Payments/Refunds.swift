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
        
        /// Shows details for a refund, by ID.
        ///
        /// A successful request returns the HTTP 200 OK status code and a JSON response body that shows refund details.
        ///
        /// - Parameter refund: The PayPal-generated ID for the refund for which to show details.
        /// - Returns: The refund for the given ID, wrapped in an `EventLoopFuture`.
        public func get(_ refund: String) -> EventLoopFuture<Refund> {
            return self.client.get(self.path + refund, as: Refund.self)
        }
    }
}
