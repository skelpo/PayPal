import PayPal
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
        /// - Returns: The authorization details for the ID passed in, wrapped in an `EventLoopFuture`.
        public func get(_ authorization: String) -> EventLoopFuture<Authorization> {
            return self.client.get(self.path + authorization, as: Authorization.self)
        }
        
        /// Captures an authorized payment, by ID.
        ///
        /// A successful request returns the HTTP 201 Created status code
        /// and a JSON response body that shows captured payment details.
        ///
        /// - Parameters:
        ///   - authorization: The PayPal-generated ID for the authorized payment to capture.
        ///   - capture: The capture information for the payment, which will be the body for the request.
        ///   - prefer: The preferred server response upon successful completion of the request.
        ///   - requestID: A unique user-generated ID that the server stores for a period of time.
        ///     Use this header to enforce idempotency on REST API POST calls.
        ///
        /// - Returns: The captured payment, wrapped in an `EventLoopFuture`.
        public func capture(
            _ authorization: String,
            capture: Authorization.Capture,
            prefer: ResponseReturn = .minimal,
            requestID: String? = nil
        ) -> EventLoopFuture<Capture> {
            var headers: HTTPHeaders = ["Prefer": prefer.rawValue]
            if let request = requestID {
                headers.add(name: "PayPal-Request-Id", value: request)
            }
            
            return self.client.post(self.path + authorization, headers: headers, body: capture, as: Capture.self)
        }
        
        /// The preferred server response upon successful completion of a request.
        public enum ResponseReturn: String {
            
            /// The server returns a minimal response to optimize communication between the API caller and the server.
            /// A minimal response includes the `id`, `status` and HATEOAS links.
            case minimal = "return=minimal"
            
            /// The server returns a complete resource representation, including the current state of the resource.
            case representation = "return=representation"
        }
    }
}
