import PayPal
import Vapor

extension Webhooks {
    
    /// The controller for the `/verify-webhook-signature` resource of the Webhooks PayPal API.
    public final class Verification: VersionedController {
        
        /// See `VersionedController.client`
        public let client: PayPalClient
        
        /// See `VersionedController.resource`.
        public let resource: [String]
        
        /// See `VersionedController.init(client:)`.
        public init(client: PayPalClient) {
            self.client = client
            self.resource = ["notifications", "verify-webhook-signature"]
        }
        
        /// Verifies a webhook signature.
        ///
        /// A successful request returns the HTTP 200 OK status code and a JSON response
        /// body that shows the verification status.
        ///
        /// - Parameter signature: The `Webhook` object signature that will be the request's body to be verified.
        /// - Returns: The verification result, wrapped in an `EventLoopFuture`.
        public func verify(signature: Webhook.Signature) -> EventLoopFuture<Webhook.Signature.Result> {
            let root = self.client.environment.domain + "/v" + self.client.version.rawValue
            return self.client.post(
                root + "/notifications/verify-webhook-signature",
                body: signature,
                as: Webhook.Signature.Result.self
            )
        }
    }
}
