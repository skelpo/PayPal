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
        
        /// Shows details for a captured payment, by ID.
        ///
        /// A successful request returns the HTTP 200 OK status code and
        /// a JSON response body that shows captured payment details.
        ///
        /// - Parameter capture: The PayPal-generated ID for the captured payment for which to show details.
        /// - Returns: The captured payment for the ID, wrapped in an `EventLoopFuture`.
        public func get(_ capture: String) -> EventLoopFuture<Capture> {
            return self.client.get(self.path + capture, as: Capture.self)
        }
    }
}
