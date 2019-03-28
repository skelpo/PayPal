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
        
        /// Refunds a captured payment, by ID. For a full refund, include an empty payload in the JSON request body.
        /// For a partial refund, include an `amount` object in the JSON request body.
        ///
        /// A successful request returns the HTTP 201 Created status code and a JSON response body that shows refund details.
        ///
        /// - Parameters:
        ///   - capture: The PayPal-generated ID for the captured payment to refund.
        ///   - refund: The refund data for the API. This will be the request body.
        ///   - prefer: The preferred server response upon successful completion of the request.
        ///   - requestID: A unique user-generated ID that the server stores for a period of time.
        ///     Use this header to enforce idempotency on REST API POST calls.
        ///
        /// - Returns: The refunded payment, wrapped in an `EventLoopFuture`.
        public func refund(
            _ capture: String,
            refund: Capture.Refund? = nil,
            prefer: ResponseReturn = .minimal,
            requestID: String? = nil
        ) -> EventLoopFuture<Refund> {
            var headers: HTTPHeaders = ["Prefer": prefer.rawValue]
            if let request = requestID {
                headers.add(name: "PayPal-Request-Id", value: request)
            }
            
            return self.client.post(self.path + capture + "/refund", headers: headers, body: refund, as: Refund.self)
        }
    }
}
